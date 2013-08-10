# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'borneo/version'

Gem::Specification.new do |spec|
  spec.name          = "borneo"
  spec.version       = Borneo::VERSION
  spec.authors       = ["Joe Geldart"]
  spec.email         = ["joe@joegeldart.com"]
  spec.description   = %q{Borneo hacks-and-slashes through the complexity of Google's APIs}
  spec.summary       = %q{If you're spending more time on Google data boilerplate than code, Borneo provides an answer.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "google-api-client"
  spec.add_dependency "signet"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "debugger"
end
