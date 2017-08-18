WebpackManifestPlugin.configure do |c|
  c.cache_manifest = Rails.env.production? ? true : false
  c.logger = Rails.logger
end
