require 'oj'
require 'logger'
require 'active_support'

require 'webpack_manifest_plugin/version'
require 'webpack_manifest_plugin/configuration'
require 'webpack_manifest_plugin/view_helpers'

require 'webpack_manifest_plugin/engine' if defined?(Rails)

# Convenience methods to configurations.
module WebpackManifestPlugin
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end

  def self.logger
    WebpackManifestPlugin.configuration.logger
  end

  def self.app_root
    WebpackManifestPlugin.configuration.app_root
  end
end
