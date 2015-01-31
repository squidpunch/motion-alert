# -*- encoding: utf-8 -*-
VERSION = "0.1"

Gem::Specification.new do |spec|
  spec.name          = "motion-alert"
  spec.version       = VERSION
  spec.authors       = ["David Larrabee"]
  spec.email         = ["dave@larrabeefamily.com"]
  spec.description   = %q{Proper iOS alerts}
  spec.summary       = %q{Proper iOS alerts}
  spec.homepage      = "https://github.com/squidpunch/motion-alert"
  spec.license       = "MIT"

  files = []
  files << 'README.md'
  files.concat(Dir.glob('lib/**/*.rb'))
  spec.files         = files
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake"
  spec.add_development_dependency("motion-stump", "~> 0.3")
end
