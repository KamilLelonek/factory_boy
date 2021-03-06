# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "factory_boy/version"

Gem::Specification.new do |spec|
  spec.name          = "factory_boy"
  spec.version       = FactoryBoy::VERSION
  spec.authors       = ["Kamil Lelonek"]
  spec.email         = ["squixy.sln@gmail.com"]
  spec.summary       = "Simplified FactoryGirl"
  spec.description   = spec.summary
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake",    "~> 10.0"
  spec.add_development_dependency "rspec",   "~> 3.0"
  spec.add_development_dependency "rubocop"
end
