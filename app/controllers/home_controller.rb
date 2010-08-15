class HomeController < ApplicationController
  
  def index
    @images = Album.find(580).images
  end
end
