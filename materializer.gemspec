# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'materializer/version'

Gem::Specification.new do |spec|
  spec.name          = 'materializer'
  spec.version       = Materializer::VERSION
  spec.authors       = ['Marco Plüss', 'Lukas Westermann']
  spec.email         = ['marco@at-point.ch', 'lukas@at-point.ch']

  spec.summary       = %q{TODO: Write a short summary, because Rubygems requires one.}
  spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = 'https://github.com/at-point/materializer'
  spec.license       = 'UNLICENSED'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host'
  spec.metadata['allowed_push_host'] = "https://do-not-allow-push.rubygems"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w{lib}

  spec.required_ruby_version = '>= 2.2'

  spec.add_dependency 'railties', '>= 4.1', '< 5'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '> 3.0'
end
