# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mtl/version'

Gem::Specification.new do |spec|
  spec.name          = 'mtl'
  spec.version       = Mtl::VERSION
  spec.authors       = ['Marco Plüss', 'Lukas Westermann']
  spec.email         = ['marco@at-point.ch', 'lukas@at-point.ch']

  spec.summary       = 'Write a summary.'
  spec.description   = 'Write a somehwat longer description about our neat-o little gem.'
  spec.homepage      = 'https://github.com/at-point/mtl'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host'
  spec.metadata['allowed_push_host'] = 'https://do-not-allow-push.rubygems'

  spec.files         = %w{.gitignore Gemfile Rakefile LICENSE.txt README.md
                          mtl.gemspec package.json} +
                       Dir['{lib,app,bin,vendor,spec}/**/*.{rb,erb,scss,eot,svg,ttf,woff}']
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w{lib}

  spec.required_ruby_version = '>= 2.2'

  spec.add_dependency 'railties', '>= 4.2', '< 5'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '> 3.0'
  spec.add_development_dependency 'actionview'
end
