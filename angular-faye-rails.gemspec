# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'angular-faye-rails/version'

Gem::Specification.new do |spec|
  spec.name          = "angular-faye-rails"
  spec.version       = AngularFaye::Rails::VERSION
  spec.authors       = ["Tymon Tobolski"]
  spec.email         = ["i@teamon.eu"]
  spec.description   = %q{Angular + Faye, packaged for Rails assets pipeline}
  spec.summary       = %q{Angular + Faye, packaged for Rails assets pipeline}
  spec.homepage      = "http://github.com/rails-assets/angular-faye-rails"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "angular-rails"
  spec.add_dependency "faye"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
