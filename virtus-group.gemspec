# encoding: utf-8

require File.expand_path('../lib/virtus/group/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "virtus-group"
  spec.version       = Virtus::Group::VERSION
  spec.authors       = ["Spas Poptchev"]
  spec.email         = ["spas.poptchev@me.com"]
  spec.description   = %q{Define groups over virtus attributes.}
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/spoptchev/virtus-group"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ["lib"]

  spec.add_dependency "virtus", ">= 1.0.0"
  spec.add_dependency "active_support", ">= 3.0.0"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 10.1"
end
