# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ruby/bitmap/fonts/version'

Gem::Specification.new do |spec|
  spec.name          = "ruby-bitmap-fonts"
  spec.version       = Ruby::Bitmap::Fonts::VERSION
  spec.authors       = ["Markus Fenske"]
  spec.email         = ["iblue@gmx.net"]

  spec.summary       = %q{A BDF (Glyph Bitmap Distribution Format) renderer}
  spec.description   = %q{This gem allows you to render bitmap fonts in the BDF format}
  spec.homepage      = "https://github.com/iblue/ruby-bitmap-fonts"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "byebug"
end
