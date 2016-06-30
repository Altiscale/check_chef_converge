# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'check_chef_converge/version'

Gem::Specification.new do |spec|
  spec.name          = "check_chef_converge"
  spec.version       = CheckChefConverge::VERSION
  spec.authors       = ["Travis Thompson"]
  spec.email         = ["travis@altiscale.com"]

  spec.summary       = %q{Nagios/Sensu check for chef convergence on a chef search}
  spec.description   = File.read(File.join(__dir__, 'README.md'))
  spec.homepage      = "https://github.com/Altiscale/check_chef_converge"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "nagiosplugin", "~> 3.0"
  spec.add_dependency "ridley", "~> 4.5"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
