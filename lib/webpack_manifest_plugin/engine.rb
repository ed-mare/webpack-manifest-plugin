module WebpackManifestPlugin
  # Railtie hooks for gem.
  class Engine < Rails::Engine
    initializer 'webpack_manifest_plugin.initializers' do |app|
      ActiveSupport.on_load :action_view do
        include ViewHelpers
      end
      # assign Rails.root to app_root
      WebpackManifestPlugin.configuration.app_root = app.root
    end
    rake_tasks do |app|
      WebpackManifestPlugin.configuration.app_root = app.root
      Dir[File.join(File.dirname(__FILE__), 'tasks/*.rake')].each { |f| load f }
    end
  end
end
