# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'caminio/sky/version'

Gem::Specification.new do |spec|
  spec.name          = "caminio-sky"
  spec.version       = Caminio::Sky::VERSION
  spec.authors       = ["thorsten zerha"]
  spec.email         = ["thorsten.zerha@tastenwerk.com"]
  spec.summary       = %q{API for user authentication and license management}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'sequel', '~> 4.17.0'
  spec.add_dependency 'sqlite3', '~> 1.3.10'
  spec.add_dependency 'grape', '~> 0.9.0'
  spec.add_dependency 'grape-swagger', '~> 0.8.0'
  spec.add_dependency 'hashie', '~> 3.3.2'
  spec.add_dependency 'puma', '~> 2.10.2'
  spec.add_dependency 'guard-puma', '~> 0.3.1'
  spec.add_dependency 'bcrypt', '~> 3.1.9'
  spec.add_dependency 'rack-test', '~> 0.6.2'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"

end
