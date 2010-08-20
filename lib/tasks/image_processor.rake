namespace :image_processor do
  desc "Get all images from Smugmug"
  task :get_all => :environment do
    SmugmugImporter.get_all()
  end
  
  desc "Get images for used galleries in the menu structure"
  task :get_used => :environment do
    SmugmugImporter.get_only_used()
  end
  
  
end