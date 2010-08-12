class SmugmugImporter
  class << self
    def get_smugmug_connection
      smug_settings = YAML.load_file(Rails.root.join("config", "smugmug.yml"))[Rails.env]
      Smile.auth(smug_settings["user_name"], smug_settings["password"])
    end
  
    def get_albums
      conn = get_smugmug_connection
      conn.albums.each do |album|
        
      end
    end
  
    def get_album
    
    end
  
    def get_photo
    
    end
  end
end