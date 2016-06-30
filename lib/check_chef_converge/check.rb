require 'check_chef_converge'
require 'nagiosplugin'
require 'ridley'

module CheckChefConverge
  class Check < Nagios::Plugin
    def initialize(options)
      @warn = options[:warn_minutes]
      @crit = options[:crit_minutes]
      @query = options[:query]
      @nodes = {}
      @warning = {}
      @critical = {}
      @start_time = Time.now.to_i

      if options[:chef_server_url]
        client_key = if options[:chef_client_key]
                       options[:chef_client_key]
                     elsif options[:chef_client_key_file]
                       File.read(options[:chef_client_key_file])
                     else
                       raise ArgumentError, 'Must pass either --chef-client-key'\
                         ' or --chef-client-key-file if passing --chef-server-url'
                     end
        @ridley = Ridley.new(
          server_url: options[:chef_server_url],
          client_name: options[:chef_client_name],
          client_key: client_key)
      elsif options[:chef_client_config]
        @ridley = Ridley.from_chef_config(options[:chef_client_config])
      else
        @ridley = Ridley.from_chef_config
      end
    end

    def critical?
      @critical.count > 0
    end

    def warning?
      @warning.count > 0
    end

    def ok?
      true
    end

    def check
      @ridley.search(:node, @query).each do |node|
        @nodes[node['automatic']['fqdn']] = (@start_time - node['automatic']['ohai_time'].to_i) / 60
      end
      @ridley.log.level = Logger::FATAL

      @nodes.each do |node,time|
        if time >= @crit
          @critical[node] = time
          @nodes.delete(node)
        elsif time >= @warn
          @warning[node] = time
          @nodes.delete(node)
        end
      end
    end

    def message
      crit = warn = ok = ''
      if @critical.count > 0
        crit = "Critical Nodes: " << @critical.map{|k,v| "#{k}:#{v}m"}.join(',')
      end

      if @warning.count > 0
        warn = "Warning Nodes: " << @warning.map{|k,v| "#{k}:#{v}m"}.join(',')
      end

      if @nodes.count > 0
        ok = 'OK Nodes: ' << @nodes.map{|k,v| "#{k}:#{v}m"}.join(',')
      end
      return [crit, warn, ok].reject(&:empty?).join(' ; ')
    end
  end
end
