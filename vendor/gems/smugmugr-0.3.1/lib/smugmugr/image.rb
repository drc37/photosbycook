module Smugmugr
  class Image
    attr_accessor :album, :id, :key, :extras
    
    @@attributes = [:id,:Key,:Album,:Altitude,:Caption,:Date,:Duration,:FileName,:Format,:Height,:Hidden,
      :Keywords,:LargeURL,:LastUpdated,:Latitude,:Longitude,:MD5Sum,:MediumURL,:OriginalURL,:Position,:Serial,
      :Size,:SmallURL,:ThumbURL,:TinyURL,:Video320URL,:Video640URL,:Video960URL,:Video1280URL,:Video1920URL,:Width,
      :X2LargeURL,:X3LargeURL,:XLargeURL]
    @@complex_attributes = [:Album]
    
    def initialize(album)
      @album = album
    end
    
    def get(*extras)
      extras = [extras] unless extras.is_a?(Array)
      Image.get(self.album, :extras => extras)
    end
    
    class << self
      def get(album, args={})
        args[:heavy] ||= false
        args[:extras] ||= []
        params = {
          :method => smug_method + 'get',
          :AlbumID => album.id,
          :AlbumKey => album.key
        }
        params.merge!(:Heavy => args[:heavy]) if args[:heavy]
        params.merge!(:Extras => args[:extras].collect(&:to_s).join(',')) if args[:extras].any?
        
        json = album.call(params)
        parse_response(json, album, params[:Extras])
      end
      
      def smug_method
        return "smugmug.images."
      end
      
      def parse_response(json, album, extra_params)
        album = json['Album']
        album['Images'].map{ |image_json|
          image = Image.new(album)
          image.id = image_json['id']
          image.key = image_json['Key']
          image.extras = {}
          @@attributes.each{ |key|
            next unless image_json.has_key?(key.to_s)

            image.extras[key] = if @@complex_attributes.include?(key)
              Object.class_eval("Smugmugr::Image::#{key}").new(image_json[key.to_s])
            else
              image_json[key.to_s]
            end
          }
          image
        }
      end
    
    end
    
    def method_missing(method)
      # check extras for method_name, MethodName
      methods = [method.to_s.classify, method.to_s]
      
      # handle _URL methods differently, .classify results in: "fancy_url".classify => "FancyUrl"
      if method.to_s =~ /url|Url|URL/
        methods << method.to_s.gsub(/url|Url/,'URL').classify
      end
      
      methods.each do |extras_attribute|
        return self.extras[extras_attribute.to_sym] if self.extras.has_key?(extras_attribute.to_sym)
      end
      
      # if it in @@attributes but not populated, return nil
      return nil unless (methods.collect(&:to_sym) & @@attributes).empty?
      
      # otherwise, move along
      super(method)
    end
    
    class Album
      attr_accessor :id, :key, :url
      def initialize(json)
        self.id = json["id"]
        self.key = json["Key"]
        self.url = json["URL"]
      end
    end
  end
end