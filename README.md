# Materializer

![Tardis: Materializing](http://67.media.tumblr.com/5afe48c312ae01b8911eac26fa59dbb2/tumblr_ngya1wnTRm1sofmw0o1_500.gif)

Welcome to **Materializer**, this is a gem we use at [at-point](https://at-point.ch)
to simplify UI designs for back-office heavy applications by leveraging the following
tools:

- [Materialize CSS][materialize]
- [Material Icons][icons] font from Google
- [Rails][rails] and it's asset pipeline
- Google Material Design

## Installation

Add this line to your Rails application's `Gemfile`:

```ruby
gem 'materializer', git: 'https://github.com/at-point/materializer'
```

then execute:

```bash
$> bundle
```

And finally run the installer to copy the "base files" to your application:

```
$> ./bin/rails generate materializer:install
# This copies the following files:
#    - app/assets/stylesheets/materialize.scss
#    - app/assets/stylesheets/materialize/_color.scss
#    - app/assets/stylesheets/materialize/_variables.scss
```

Last but not least change your `application.css` to include:

```
//= require materialize
```

Ensure it **does not contain** any reference to `require_tree .`, as this leads
to duplicate imports and weird asset pipeline errors.

## Usage

Customize and adapt your styling as wanted, feel free to modify things in
`_variables.scss` to your liking. Try to avoid changeing `_color.scss` when
possible.

### Rails

In addition we provide a few Rails specific helpers.

**Header**, see [header_helper.rb][header_helper.rb] for more information
and details, but a quick and dirty usage to render a navbar header is:
```haml
= materializer_header t('.title'), back: dossiers_path do
  = render 'filters'
```

## Development

For development `node` and `npm` is required.

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Update materialize-css or icons

1. Change version in `package.json`
2. Run `npm update` to fetch the new version
3. Run `./bin/pull-all`: this copies all resources to vendor/assets
4. Follow _NEXT STEPS_ closely as defined in output of `pull-all`

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/at-point/materializer.
This project is intended to be a safe, welcoming space for collaboration, and contributors
are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org)
code of conduct.

[materialize]: http://materializecss.com/
[icons]: https://design.google.com/icons/
[rails]: http://rubyonrails.org

[header_helper.rb]: https://github.com/at-point/materializer/blob/master/lib/materializer/rails/header_helper.rb
