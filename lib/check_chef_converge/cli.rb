require 'check_chef_converge'
require 'optparse'
require 'ostruct'
require 'socket'

module CheckChefConverge
  class CLI
    def self.parse(args)
      options = OpenStruct.new
      options[:warn_minutes] = 65
      options[:crit_minutes] = 70
      options[:query] = "fqdn:#{Socket.gethostname}"

      opt_parser = OptionParser.new do |opts|
        opts.banner = "Usage: #{$0}"
        opts.on('-w', '--warn-minutes MINUTES', "Warning when chef has not converged in minutes."\
                "Default #{options[:warn_minutes]}") do |ret|
          options[:warn_minutes] = ret.to_i
        end

        opts.on('-c', '--crit-minutes MINUTES', "Critical when chef has not converged in minutes."\
                "Default #{options[:crit_minutes]}") do |ret|
          options[:crit_minutes] = ret.to_i
        end

        opts.on('-q', '--query SEARCH', "Chef query to filter on. "\
                "Default '#{options[:query]}'") do |ret|
          options[:query] = ret
        end

        opts.on('--chef-client-config CONFIG', 'Chef client configuration.') do |ret|
          options[:chef_client_config] = ret
        end

        opts.on('--chef-server-url URL', 'Chef Server URL. Must pass client-name and'\
                ' client-key or client-key-file with this option.') do |ret|
          options[:chef_server_url] = ret
        end

        opts.on('--chef-client-name NAME', 'Chef Client Name. Only used with '\
                ' server-url') do |ret|
          options[:chef_client_name] = ret
        end

        opts.on('--chef-client-key KEY', 'Chef Client Key (string). Only used with '\
                ' server-url. Takes precedence over client-key-file.') do |ret|
          options[:chef_client_key] = ret
        end

        opts.on('--chef-client-key-file PATH', 'Chef Client Key File. Only used with '\
                ' server-url') do |ret|
          options[:chef_client_key_file] = ret
        end

        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end

        opts.on_tail("--version", "Show version") do
          puts CheckChefConverge::VERSION
          exit
        end
      end

      opt_parser.parse!(args)

      return options
    end
  end
end
