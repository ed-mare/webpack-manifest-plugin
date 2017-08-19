# WebpackManifestPlugin

This Ruby gem provides a way to use assets managed with `webpack` in Rails templates. JavaScript package  [webpack-manifest-plugin](https://www.npmjs.com/package/webpack-manifest-plugin) outputs a JSON file that maps assets to file paths. File paths can change depending on a webpack configuration -- a development config usually doesn't version assets while a production config does. Webpack updates CSS and JavaScript files with the file paths it outputs but not Rails templates. This gem provides a view helper for including these assets in Rails views.

##### Warning

This has not been used in a production environment - use at your own risk. Rigorous testing has not been done against different versions of Ruby and Rails -- it has been tested against Ruby 2.3.x and Rails 5.x.

##### Who would use this?

Those who already have a webpack asset workflow and only need to reference webpack assets in Rails templates. Otherwise, use [webpacker](https://github.com/rails/webpacker).

## Usage

**1) Install the [webpack-manifest-plugin](https://www.npmjs.com/package/webpack-manifest-plugin):**

```shell
npm install --save-dev webpack-manifest-plugin
```

**2) Configure your `webpack.config.js` file(s) to use this package:**

```javascript
/* add the plugin */
var ManifestPlugin = require('webpack-manifest-plugin');

/* in the plugins section */
plugins: [
  // ...
  new ManifestPlugin({
    // server public path
    publicPath: '/assets/'
  }),
  // ...
]
```

And manage your assets as you normally do with webpack.

```shell
# i,e.,
webpack -d -w
```
There is a rake task for running webpack. The advantage to using this is that ctrl-c-ing the rake task will stop webpack in watch  mode (for some reason ctrl-c doesn't stop webpack on my Ubuntu machine).

```shell
# i,e.,
rake webpack:build

# with options
rake webpack:build['-d -w --config webpack.config.prod.js']"
```

**3) Add this gem to your Rails application Gemfile and run `bundle`:**

```ruby
gem 'webpack_manifest_plugin'
```

If you are creating a new Rails app, skip sprockets and yarn (unless you need yarn).

```shell
rails new --help
#...
[--skip-yarn], [--no-skip-yarn]                    # Don't use Yarn for managing JavaScript dependencies
#...
-S, [--skip-sprockets], [--no-skip-sprockets]          # Skip Sprockets files
 #...
```

If you want UJS and actioncable, add to package.json (with appropriate versions):

```JSON
# package.json
"dependencies": {
    "actioncable": "5.1.3",
    ...
    "rails-ujs": "5.1.3",
```

**4) Configure the gem in initializers:**

```ruby
# Configurations:

# webpack_cmd - Command to execute webpack. Defaults to 'webpack'.
# cache_manifest - boolean - defaults to false. If set to true, it loads the
#     JSON file once and caches it in WebpackManifestPlugin.configuration.manifest.
#     If false, it lazy loads per request.
# logger - defaults to Logger.new(STDOUT). Set to your Rails.logger or whatever
#          logger you are using.

# create config/initializers/webpack_manifest_plugin.rb file and
# configure it for your app.

# Example:
WebpackManifestPlugin.configure do |c|
  c.webpack_cmd = 'node node_modules/webpack/bin/webpack'
  c.cache_manifest =  Rails.env.production? ?  true : false
  c.logger = Rails.logger
end
```

**5) Use the `webpack_manifest_path` view helper your Rails views:**

A webpack-manifest-plugin file looks something like this:

```JSON
{
  "common.css": "/assets/stylesheets/common.css",
  "common.js": "/assets/javascripts/common.js",
  "fonts/fontawesome-webfont.eot": "/assets/fonts/fontawesome-webfont.eot",
  "fonts/fontawesome-webfont.svg?v=4.6.3": "/assets/fonts/fontawesome-webfont.svg",
  "fonts/fontawesome-webfont.ttf?v=4.6.3": "/assets/fonts/fontawesome-webfont.ttf",
  "images/login_cover.jpg": "/assets/images/login_cover.jpg",
  "images/panel_bg.png": "/assets/images/panel_bg.png",
  "react.css": "/assets/stylesheets/react.css",
  "react.js": "/assets/javascripts/react.js",
  "welcome.css": "/assets/stylesheets/welcome.css",
  "welcome.js": "/assets/javascripts/welcome.js"
}
```

Specify the hash key in the `webpack_manifest_path` view helper:

```html
<img src="<%= webpack_manifest_path("images/login_cover.jpg") %>" />
<link href="<%= webpack_manifest_path("common.css") %>" rel="stylesheet" type="text/css">
<script src="<%= webpack_manifest_path("common.js") %>"></script>
```

## Development

1) Build the docker image:

```shell
docker-compose build
```

2) Start docker image with an interactive bash shell:

```shell
docker-compose run --rm gem
```

3) Once in bash session, code, run tests, start console, etc.

```shell
# run console with gem loaded
bundle console

# run tests
rake spec # (or bundle exec rspec)
```

## Todo

- Test rake tasks.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ed-mare/webpack_manifest_plugin. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
