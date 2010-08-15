class HomeController < ApplicationController
  
  def index
    gallery_name = params[:name]
    images = []
    if gallery_name
      Album.find_by_name(gallery_name).images
    end
    
    unless images
      Album.find_by_s_album_id(13167169).images
    end
    @images = Album.find(580).images
  end
end
