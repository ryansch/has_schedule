# -*- encoding: utf-8 -*-
require File.expand_path('../lib/has_schedule/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ryan Schlesinger"]
  gem.email         = ["ryan@instanceinc.com"]
  gem.description   = %q{Exposes an ice_cube schedule object and serializes it.}
  gem.summary       = %q{Adds schedule serialization for use with ice_cube}
  gem.homepage      = "http://github.com/ryansch/has_schedule"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "has_schedule"
  gem.require_paths = ["lib"]
  gem.version       = HasSchedule::VERSION

  gem.add_dependency 'ice_cube'
  gem.add_dependency 'andand', '~> 1.3.1'
end
