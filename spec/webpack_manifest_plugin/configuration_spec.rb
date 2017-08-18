require 'spec_helper'

describe WebpackManifestPlugin::Configuration do
  let(:config) { WebpackManifestPlugin::Configuration.new }
  let(:config_1) do
    WebpackManifestPlugin::Configuration.new.tap do |c|
      c.manifest_path = 'support/assets1/manifest.json'
      c.webpack_cmd = 'node node_modules/webpack/bin/webpack'
      c.cache_manifest = true
      c.logger = 'xyz'
      # set it to the spec directory
      c.app_root = File.expand_path('../', File.dirname(__FILE__))
    end
  end

  describe '#webpack_cmd' do
    it 'defaults to webpack' do
      expect(config.webpack_cmd).to eq('webpack')
    end
    it 'is configurable' do
      puts "config_1 == #{config_1}"
      expect(config_1.webpack_cmd).to eq('node node_modules/webpack/bin/webpack')
    end
  end

  describe '#manifest_path' do
    it 'defaults to public/assets/manifest.json' do
      expect(config.manifest_path).to eq('public/assets/manifest.json')
    end
    it 'is configurable' do
      expect(config_1.manifest_path).to eq('support/assets1/manifest.json')
    end
  end

  describe '#cache_manifest' do
    it 'defaults to false' do
      expect(config.cache_manifest).to eq(false)
    end
    it 'is configurable' do
      expect(config_1.cache_manifest).to eq(true)
    end
  end

  describe 'logger' do
    it 'defaults to Logger.new(STDOUT)' do
      expect(config.logger).to respond_to(:warn, :error)
    end
    it 'is configurable' do
      expect(config_1.logger).to eq('xyz')
    end
  end

  describe 'manifest' do
    it 'defaults to nil' do
      expect(config.manifest).to eq(nil)
    end
    it 'is a hash of a manifest file' do
      expect(config_1.manifest).to include('common.js' => '/assets/javascripts/common.js')
    end
  end
end
