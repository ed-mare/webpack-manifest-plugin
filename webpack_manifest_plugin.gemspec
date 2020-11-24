# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'webpack_manifest_plugin/version'

Gem::Specification.new do |spec|
  spec.name          = 'webpack_manifest_plugin'
  spec.version       = WebpackManifestPlugin::VERSION
  spec.authors       = ['ed-mare']

  spec.summary       = 'Gem that work with node manifest-webpack-plugin.'
  spec.description   = "Gem that work with node manifest-webpack-plugin. A view helper
                        for using webpack managed assets in Rails templates."
  spec.homepage      = 'https://github.com/ed-mare/webpack_manifest_plugin'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # If you get the check your files list error...
  # http://siawyoung.com/coding/ruby/invalid-gemspec.html

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.5'

  spec.add_dependency 'oj', '~> 3.0'
  spec.add_dependency 'railties', '>= 4.1'
  spec.add_dependency 'activesupport', '>= 4.1'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake', '~> 13.0.1'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rails', '5.2.4.4'
  spec.add_development_dependency 'rspec-rails', '4.0.1'
  spec.add_development_dependency 'rubocop', '>= 0.47'
  spec.add_development_dependency 'bundler-audit'
end
