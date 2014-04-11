# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ebook_renamer/version'

Gem::Specification.new do |spec|
  spec.name          = "ebook_renamer"
  spec.version       = EbookRenamer::VERSION
  spec.authors       = ["Burin Choomnuan"]
  spec.email         = ["agilecreativity@gmail.com"]
  spec.description   = %q{Bulk rename of ebook files (pdf, epub, mobi) based on embedded meta-data}
  spec.summary       = %q{Rename multiple ebook files (pdf, epub, mobi) based on existing meta-data in the file}
  spec.homepage      = "https://github.com/agilecreativity/ebook_renamer"
  spec.license       = "MIT"
  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "thor", "~> 0.18"
  spec.add_runtime_dependency "awesome_print", "~> 1.2"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest-spec-context", "~> 0.0.3"
  spec.add_development_dependency "guard-minitest", "~> 2.2"
  spec.add_development_dependency "minitest", "~> 4.2"
  spec.add_development_dependency "guard", "~> 2.6"
  spec.add_development_dependency "pry", "~> 0.9"
  spec.add_development_dependency "gem-ctags", "~> 1.0"
  spec.add_development_dependency "yard", "~> 0.8"
end
