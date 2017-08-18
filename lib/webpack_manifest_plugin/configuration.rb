module WebpackManifestPlugin
  # == Gem Configurations
  #
  # === Example:
  #
  #   # put in config/initializers/webpack_manifest_plugin.rb
  #   WebpackManifestPlugin.configure do |c|
  #     c.webpack_cmd = 'node node_modules/webpack/bin/webpack'
  #     c.cache_manifest =  Rails.env.production? ?  true : false
  #     c.logger = Rails.logger
  #   end
  #
  class Configuration
    # App root. Set to Rails.root in engine initializer. Otherwise empty string.
    attr_accessor :app_root

    # String. Command to execute webpack. Defaults to 'webpack'.
    # Used in rake tasks.
    attr_accessor :webpack_cmd

    # String. Relative path to app root to manifest.json file. Defaults to
    # 'public/assets/manifest.json'.
    attr_accessor :manifest_path

    # Boolean. Cache manifest.json on application loads. Otherwise,
    # it caches per request. Defaults to false.
    attr_accessor :cache_manifest

    # Defaults to Logger.new(STDOUT)
    attr_accessor :logger

    def initialize
      set_defaults
    end

    # Hash. If cache_manifest == true, it caches the manifest here the
    # first time its fetched. Otherwise, returns nil.
    def manifest
      @manifest ||= begin
        @cache_manifest ? load_manifest : nil
      end
    end

    def load_manifest
      file_path = File.join(@app_root, @manifest_path)
      Oj.load(File.read(file_path))
    end

    protected

    def set_defaults
      @app_root = ''
      @webpack_cmd = 'webpack'
      @manifest_path = 'public/assets/manifest.json'
      @cache_manifest = false
      @logger = Logger.new(STDOUT)
      @manifest = nil
    end
  end
end
