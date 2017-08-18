module WebpackManifestPlugin
  # View helpers available in the application.
  module ViewHelpers
    # Webpack manages asset paths in your CSS and Javascript files but not in your Rails
    # templates. The npm webpack-manifest-plugin generates a json file (see example
    # below). 'webpack_manifest_path' uses this file to inject the correct path.
    #
    # {
    #   "common.css": "/assets/stylesheets/common.css",
    #   "common.js": "/assets/javascripts/common.js",
    #   "fonts/fontawesome-webfont.ttf?v=4.6.3": "/assets/fonts/fontawesome-webfont.ttf",
    #   "images/panel_bg.png": "/assets/images/panel_bg.png"
    # }
    #
    # Specify an asset hash key like so:
    #
    # <img src="<%= webpack_manifest_path("images/panel_bg.png") %>" width="40px"></img>
    # <script src="<%= webpack_manifest_path("common.js") %>"></script>
    # <link href="<%= webpack_manifest_path("common.css") %>" rel="stylesheet" type="text/css">
    #
    # Returns asset path if key exists, otherwise returns the key itself. If an exception occurs,
    # it logs the error and returns an empty string.
    def webpack_manifest_path(key)
      webpack_manifest_configs[key] || key
    rescue StandardError => ex
      WebpackManifestPlugin.logger.warn "Error parsing webpack manifest JSON. #{ex.message}"
      ''
    end

    # Manifest configs as a hash.
    def webpack_manifest_configs
      c = WebpackManifestPlugin.configuration
      c.manifest || (@webpack_manifest_configs ||= c.load_manifest)
    end
  end
end
