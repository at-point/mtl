# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mtl/version'

Gem::Specification.new do |spec|
  spec.name          = 'mtl'
  spec.version       = Mtl::VERSION
  spec.authors       = ['Marco Plüss', 'Lukas Westermann', 'Loris Gavillet']
  spec.email         = ['marco@at-point.ch', 'lukas@at-point.ch', 'loris@at-point.ch']

  spec.summary       = 'Rails gem to package materialize-css for reuse between projects.'
  spec.description   = 'Reusable components and Rails helpers on top of materialize-css ' \
                       'and material-design-icons.'
  spec.homepage      = 'https://github.com/at-point/mtl'
  spec.license       = 'MIT'

  spec.files         = %w{.gitignore Gemfile Rakefile LICENSE.txt README.md
                          mtl.gemspec package.json} +
                       Dir['{lib,app,bin,vendor,spec}/**/*.{rb,erb,js,coffee,scss,gif,jpg,svg,eot,ttf,woff,woff2,ijmap}']
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w{lib}

  spec.required_ruby_version = '>= 2.2'

  spec.add_dependency 'railties', '>= 4.2', '< 6'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'yard', '~> 0.8'
  spec.add_development_dependency 'rspec', '> 3.0'
  spec.add_development_dependency 'actionview'
  spec.add_development_dependency 'simple_form', '>= 3.3'

  spec.post_install_message = "
    Some component have been extend with configuration variables, don't forget to re-generate the scss configuration or
    add the following values to your existing one:

      $chip-height: 32px !default;
      $chip-line-height: 32px !default;
      $chip-font-size: 13px !default;
      $chip-font-weight: 500 !default;
      $chip-border-radius: 16px !default;
      $badge-height: 22px !default;
      $collapsible-line-height: $collapsible-height !default;
      $navbar-line-height: $navbar-height !default;
      $navbar-line-height-mobile: $navbar-height-mobile !default;
      $sidenav-line-height: $sidenav-item-height !default;
      $collection-line-height: 1.5rem !default;"
end
