require 'tempfile'

namespace :radiant do
  namespace :extensions do
    namespace :jobs do
     
      
      desc "Copies public assets of the Jobs to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[JobsExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(JobsExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end
    end
  end
end
