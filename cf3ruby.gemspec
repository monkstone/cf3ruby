# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cf3/version'

Gem::Specification.new do |spec|
  spec.name          = "cf3"
  spec.version       = Cf3::VERSION
  spec.authors       = ["Jeremy Ashkenas", "Martin Prout"]
  spec.email         = ["martin_p@lineone.net"]
  spec.description   = <<-EOF
    A library for ruby-processing, that allows the writing of context free 
    sketches (like context free art) in a ruby DSL. It is a bit of a toy
    compared to the c++ version.  However you can get quite a bit of 
    satisfaction creating an interesting graphic, and you can't always
    predict what you are going to get.
  EOF
  spec.summary       = %q{A ruby-DSL library for CF3 sketches}
  spec.homepage      = "http://learning-ruby-processing.blogspot.co.uk/"
  spec.default_executable   = "cf3samples" 
  spec.license       = "GPL3"
  spec.files         = `git ls-files`.split($/)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.executables   = ["cf3samples"] 
  spec.require_paths = ["lib"]
  spec.add_runtime_dependency 'jruby_art', '~> 1.4.4'
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", "~> 12.0.0"
end
