# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dx/lookup/version'

Gem::Specification.new do |spec|
  spec.name          = "dx-lookup"
  spec.version       = DX::Lookup::VERSION
  spec.authors       = ["Rockwell Schrock"]
  spec.email         = ["cq@ww1x.com"]

  spec.summary       = %q{Callsign detail lookup}
  spec.homepage      = "https://github.com/schrockwell/dx-lookup"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"

  spec.add_runtime_dependency 'httparty', '~> 0.14'
  spec.add_runtime_dependency 'virtus', '~> 1.0'
end
