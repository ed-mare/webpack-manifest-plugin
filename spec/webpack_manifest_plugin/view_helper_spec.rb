require 'spec_helper'

class Klass
  include WebpackManifestPlugin::ViewHelpers
end

describe WebpackManifestPlugin::ViewHelpers do
  before(:each) do
    WebpackManifestPlugin.configure do |c|
      c.manifest_path = 'support/assets1/manifest.json'
      c.app_root = File.expand_path('../', File.dirname(__FILE__)) # spec folder
    end
  end
  after(:each) do
    WebpackManifestPlugin.configuration.send(:set_defaults)
  end
  let(:klass) { Klass.new }

  describe '#webpack_manifest_path(key)' do
    it 'returns the file path for the key' do
      expect(klass.webpack_manifest_path('common.js')).to eq('/assets/javascripts/common.js')
    end
    it "returns the key path when key doesn't exist" do
      expect(klass.webpack_manifest_path('foo.js')).to eq('foo.js')
    end
    it 'returns an empty string when there is no manifest (when exeption occurs)' do
      WebpackManifestPlugin.configure do |c|
        c.manifest_path = 'i/dont/exist/manifest.json'
      end
      expect(klass.webpack_manifest_path('foo.js')).to eq('')
    end
  end
end
