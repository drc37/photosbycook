class SmugmugImporter
  class << self
    def get_smugmug_connection
      smug_settings = YAML.load_file(Rails.root.join("config", "smugmug.yml"))[Rails.env]
      p "#{smug_settings["user_name"]} - #{smug_settings["password"]}"
      Smile.auth(smug_settings["user_name"], smug_settings["password"])
    end
    
    def get_all
      conn = get_smugmug_connection
      
      # get_categories conn
      # get_subcategories conn
      get_albums conn
      # get_photos
    end
    
    def get_category(album)
      begin
        cat = Category.find_or_create_by_s_category_id(album.attributes.subcategory[:id])
        cat.update_attributes(:title => album.attributes.subcategory[:name])
        cat
      rescue
      end
    end
    
    def get_subcategory(album)
      begin
        subcat = Subcategory.find_or_create_by_s_subcategory_id(s_id)
        subcat.update_attributes(:title => subcategory)
        subcat
      rescue
      end
    end
  
    def get_albums(conn = get_smugmug_connection)
      conn = get_smugmug_connection
      conn.albums.each do |album|
        # record each album
          gallery = Album.find_or_create_by_s_album_id(album.album_id)
          gallery.update_attributes(
              :subcategory => get_subcategory(album),
              :category => get_category(album),
              :title => album.title,
              :description => album.description
            )
          
        get_photos(album, gallery)      
      end             
    end               
                      
    def get_photos(album, gallery)
      begin
        album.photos.each do |photo|
          image = Images.find_or_create_by_s_image_id(photo.image_id)
      
          image.update_attributes(
            :width => get_attribute(photo, "width"),
            :height => get_attribute(photo, "height"),
            :caption => get_attribute(photo, "caption"),
            :file_name => get_attribute(photo, "filename"),
            :album => gallery,
            :keywords => get_attribute(photo, "keywords"),
            :size => get_attribute(photo, "size"),
            :TinyURL => get_attribute(photo, "tinyurl"),
            :ThumbURL => get_attribute(photo, "thumburl"),
            :SmallURL => get_attribute(photo, "smallurl"),
            :MediumURL => get_attribute(photo, "mediumurl"),
            :LargeURL => get_attribute(photo, "largeurl"),
            :XLargeURL => get_attribute(photo, "xlargeurl"),
            :X2LargeURL => get_attribute(photo, "x2largeurl"),
            :X3LargeURL => get_attribute(photo, "x3largeurl"),
            :OriginalURL => get_attribute(photo, "originalurl"),
            :Video320URL => get_attribute(photo, "video320url"),
            :Video640URL => get_attribute(photo, "video650url"),
            :Video960URL => get_attribute(photo, "video960url"),
            :Video12800URL => get_attribute(photo, "video12800url")
          )
        end
      rescue
      end
    end
    
    def get_attribute(object, attribute)
      begin
        object.send(attribute)
      rescue
      end
    end
  end
end