module Smugmugr
  class User
    attr_accessor :credentials, :session_id, :session, :email, :password
    # set by smugmug response data
    attr_accessor :user_id, :nickname, :password_hash, :filesize_limit
    
    def initialize(api_key, args={})
      @credentials = {}
      args.each{ |k,v|
        self.send("#{k}=", v) if self.respond_to?(k)
      }
      @session = Smugmugr::Session.new(api_key, self, args[:session_args] || {})
    end
    
    def send_request_with_session(params)
      @session.send_request_with_session(params)
    end
    
    def albums(*extras)
      extras = [extras] unless extras.is_a?(Array)
      Album.get(self, :extras => extras)
    end
    
    def session_id
      @session.session_id
    end
    
    def call(params={})
      @session.call(params)
    end
  end
end