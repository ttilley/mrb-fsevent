# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mrb-fsevent/version"

Gem::Specification.new do |s|
  s.name        = "mrb-fsevent"
  s.version     = FSEvent::VERSION
  s.platform    = Gem::Platform::MACRUBY
  s.authors     = ["Travis Tilley"]
  s.email       = ["ttilley@gmail.com"]
  s.summary     = %q{MacRuby FSEvents library and CLI utility}
  s.description = %q{MacRuby FSEvents library and CLI utility}

  s.rubyforge_project = "mrb-fsevent"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'mac_bacon', '>= 1.3'
end
