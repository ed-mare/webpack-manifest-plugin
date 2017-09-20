require 'fileutils'
require 'pty'

namespace :webpack_manifest_plugin do
  desc 'Deletes all files in <app root>/public/assets.'
  task :clean do
    app_root = WebpackManifestPlugin.app_root.to_s
    folder = File.join(app_root, 'public/assets')
    if !app_root.empty? && Dir.exist?(folder)
      FileUtils.remove_entry_secure(folder, secure: true)
    else
      puts "Directory #{folder} not found."
    end
  end

  desc "Run webpack. Assumes webpack is installed at node_modules/webpack/bin/webpack.
  Use with or without options. Examples:
     rake webpack_manifest_plugin:build
     rake webpack_manifest_plugin:build['-d --config webpack.config.prod.js']"
  task :build, :options do |_t, args|
    cmd = "#{WebpackManifestPlugin.configuration.webpack_cmd} #{args[:options]}"
    puts "Executing #{cmd}..."

    begin
      PTY.spawn(cmd) do |stdout, _stdin, _pid|
        begin
          stdout.each { |line| print line }
        rescue Errno::EIO
          puts 'The process has finished.'
        end
      end
    rescue PTY::ChildExited
      puts 'webpack exited!'
    end
  end
end
