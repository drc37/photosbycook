require 'rubygems'
require 'curb'
require 'json'
require 'yaml'

require 'smugmugr/user'
require 'smugmugr/album'
require 'smugmugr/image'
require 'smugmugr/session'

module Smugmugr
  # TODO: attempt to load from a configuration file
end

# TODO: keep this?
def logger
  @logger ||= if Module.constants.include?('RAILS_DEFAULT_LOGGER')
    RAILS_DEFAULT_LOGGER
  else
    Logger.new('simple_smugmug.log')
  end
end