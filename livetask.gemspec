# -*- encoding: utf-8 -*-
require File.expand_path('../lib/livetask/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alexey Krasnoperov"]
  gem.email         = ["Alexey.Krasnoperov@gmail.com"]
  gem.description   = %q{Live broadcast from a background jobs}
  gem.summary       = %q{Gem that displays real-time progress of background job on your page}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "livetask"
  gem.require_paths = ["lib"]
  gem.version       = Livetask::VERSION
end
