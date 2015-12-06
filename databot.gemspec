# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'databot/version'

Gem::Specification.new do |spec|
  spec.name          = "databot"
  spec.version       = Databot::VERSION
  spec.authors       = ["Clay Gimenez", "Mary Schmidt"]
  spec.email         = ["team.databot@gmail.com"]

  spec.summary       = "Databot -- Machine Learning and Data Science in Ruby"
  spec.description   = "Databot will provide a variety of machine learning and data science tools.  Currently in development."
  spec.homepage      = "http://www.github.com/claygimenez/databot"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.test_files    = `git ls-files -- {spec,features}/*`.split("\n")
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
