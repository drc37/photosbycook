module Smugmugr
  class Album
    attr_accessor :user, :id, :title, :key, :pub_key, :session_id, :extras
    
    #############################################
    # all attributes available on an Album
    #############################################
    @@attributes = [:id,:Key,:Backprinting,:CanRank,:Category,:Clean,:ColorCorrection,:Comments,:Community,:Description,:EXIF,
      :External,:FamilyEdit,:Filenames,:FriendEdit,:Geography,:Header,:HideOwner,:Highlight,:ImageCount,:Larges,:LastUpdated,
      :Originals,:Password,:PasswordHint,:Position,:Printable,:ProofDays,:Protected,:Public,:Share,:SmugSearchable,:SortDirection,
      :SortMethod,:SquareThumbs,:SubCategory,:Template,:Theme,:Title,:UnsharpAmount,:UnsharpRadius,:UnsharpSigma,:UnsharpThreshold,
      :Watermark,:Watermarking,:WorldSearchable,:X2Larges,:X3Larges,:XLarges]
    @@complex_attributes = [:Category, :Community, :Highlight, :SubCategory, :Template, :Theme, :Watermark]
      
    def initialize(user)
      @user = user
    end
    
    #############################################
    # class
    #############################################
    class << self
      def get(user, args={})
        args[:heavy] ||= false
        args[:extras] ||= []
        params = {
          :method => 'smugmug.albums.get'
        }
        params.merge!(:Heavy => args[:heavy].to_s) if args[:heavy]
        params.merge!(:Extras => args[:extras].collect(&:to_s).join(','))
        
        json = user.call(params)
        return albums_from_json(json, user, args[:extras])
      end
      
      def albums_from_json(json, user, extra_params=[])
        albums = json["Albums"].map do |album|
          album_from_json(album, user, extra_params)
        end
      end
      
      def album_from_json(json, user, extras=[])
        a = Album.new(user)
        a.id = json['id']
        a.title = json['Title']
        a.key = json['Key']
        a.extras = {}
        @@attributes.each{ |key|
          next unless json.has_key?(key.to_s)
          
          a.extras[key] = if @@complex_attributes.include?(key)
            Object.class_eval("Smugmugr::Album::#{key}").new(json[key.to_s])
          else
            json[key.to_s]
          end
        }
        a
      end
    end
    
    #############################################
    # instance
    #############################################
    def images(*extras)
      extras = [extras] unless extras.is_a?(Array)
      Image.get(self, :extras => extras)
    end
    
    def call(params)
      user.call(params)
    end
    
    def get_info
      params = {
        :method => 'smugmug.albums.getInfo',
        :AlbumID => self.id,
        :AlbumKey => self.key
      }
      json = user.call(params)
      return Album.album_from_json(json["Album"], user, @@attributes)
    end
    
    def method_missing(method)
      # check extras for method_name, MethodName
      methods = [method.to_s.classify, method.to_s]
      methods.each do |extras_attribute|
        return self.extras[extras_attribute.to_sym] if self.extras.has_key?(extras_attribute.to_sym)
      end
      
      # if it in @@attributes but not populated, return nil
      return nil unless (methods.collect(&:to_sym) & @@attributes).empty?
      
      # otherwise, move along
      super(method)
    end
    
    class Simple
      attr_accessor :id, :name
      def initialize(json)
        self.id = json["id"]
        self.name = json["Name"]
      end
    end
    
    class Category < Simple
    end
    
    class Community < Simple
    end
    
    class Highlight
      attr_accessor :id, :key
      def initialize(json)
        self.id = json["id"]
        self.key = json["Key"]
      end
    end
    
    class SubCategory < Simple
    end
    
    class Template
      attr_accessor :id
      def initialize(json)
        self.id = json["id"]
      end
    end
    
    class Theme
      attr_accessor :id, :name, :type
      def initialize(json)
        self.id = json["id"]
        self.name = json["Name"]
        self.type = json["Type"]
      end
    end
    
    class Watermark < Simple
    end
  end
end