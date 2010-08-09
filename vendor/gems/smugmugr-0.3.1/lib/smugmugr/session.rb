require 'curl'
require 'json'

module Smugmugr
  class Session
    attr_accessor :params, :host, :port, :timeout, :retry, :use_ssl, :session_id
    attr_accessor :api_path, :session, :api_key, :user, :attributes, :headers
    
    def initialize(api_key, user, args={})
      @user = user
      @api_key = api_key
      # TODO: externalize, make overrideable from ~/smugmugr.yml or RAILS_ROOT/config/smugmugr.yml
      attributes = {
        :host => 'api.smugmug.com',
        :port => 443,
        :timeout => 10,
        :retry => 1, # no retry for now
        :use_ssl => true,
        :api_path => '/services/api/json/1.2.2/',
        :headers => {
          "User-Agent" => 'smugmugr v0.0.1'
        }
      }
      attributes.merge!(args)
      attributes.each{|k,v|
        self.send("#{k}=", v) if self.respond_to?(k)
      }
    end
    
    def establish_session
      if user.email && user.password
        establish_session_with_login
      else 
        establish_anonymous_session
      end
      return self
    end
    
    def establish_anonymous_session
      establish_new_session({:method => 'smugmug.login.anonymously'})
    end
    
    def establish_session_with_login
      establish_new_session({:method => 'smugmug.login.withPassword', 
                             :EmailAddress => "#{user.email}", 
                             :Password => "#{user.password}"})
    end
    
    def establish_session_with_open_auth
      raise "unimplemented"
    end
    
    def get_session_id
      @session ||= establish_session
      return @session.session_id
    end
    
    def call(params={}, with_session_id=true)
      params.merge!(:SessionID => "#{get_session_id}") if with_session_id
      data = nil
      begin
        url = protocol + @host + build_url_request(params)
        puts "\nsending: #{url}\n"
        response = Curl::Easy.perform(url) do |easy|
          easy.headers.merge!(headers)
          easy.timeout = @timeout
        end
        
        data = response.body_str unless response.nil?
      rescue Timeout::Error => e
        # TODO: custom exception
        raise e
      end
      # check status of response
      json = JSON.parse(data)
      
      if json['stat'] != 'ok'
        # TODO: custom exception
        raise "error from smugmug: #{json.inspect}"
      end
      
      return json
    end
    
    def establish_new_session(params)
      begin
        json = call(params, false)
        
        set_user_data(json["Login"])
        self.session_id = json["Login"]["Session"]["id"]
      rescue => e
        # TODO: custom exception
      end      
    end
    
    private
    
    def set_user_data(json)
      @user.user_id = json["User"]["id"]
      @user.nickname = json["User"]["NickName"]
      @user.password_hash = json['PasswordHash']
      @user.filesize_limit = json['FileSizeLimit']
    end
    
    private
    
    def protocol
      return "http#{'s' if @use_ssl}://"
    end
    
    # {:foo => 'bar', :baz => "blingy things"} => ['foo=bar','baz=blingy%20things']
    def encode_params(raw_params)
      return raw_params.map{ |k,v|
        [k.to_s,CGI::escape(v.to_s)].join('=')
      }
    end
    
    # returns everything except protocol/host
    def build_url_request(params)
      params.merge!(:APIKey => @api_key)
      param_string = encode_params(params)
      return @api_path + '?' + param_string.join('&')
    end
    
  end
end