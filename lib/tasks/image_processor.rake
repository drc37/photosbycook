namespace :image_processor do
  desc "Get all images from Smugmug"
  task :get_all => :environment do
    SmugmugImporter.get_all()
  end
end