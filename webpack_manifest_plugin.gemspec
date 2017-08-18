# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'webpack_manifest_plugin/version'

Gem::Specification.new do |spec|
  spec.name          = 'webpack_manifest_plugin'
  spec.version       = WebpackManifestPlugin::VERSION
  spec.authors       = ['ed-mare']

  spec.summary       = 'Gem that work with npm webpack_manifest_plugin.'
  spec.description   = 'Includes view helpers for injecting paths into Rails template and rake tasks.'
  spec.homepage      = 'https://github.com/ed-mare/webpack-manifest-plugin'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
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
  spec.required_ruby_version = '>= 2.0'

  spec.add_dependency 'oj', '>= 2.0'
  spec.add_dependency 'railties', '>= 4.1'
  spec.add_dependency 'activesupport', '>= 4.1'

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rails', '>= 4.1'
  spec.add_development_dependency 'rspec-rails', '>= 3.5'
  spec.add_development_dependency 'rubocop', '>= 0.47'
end
