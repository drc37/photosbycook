class HomeController < ApplicationController
  
  def index
    gallery_name = params[:id]
    images = []
    if gallery_name
      images = Album.find_by_s_album_id(gallery_name.to_i).images
    end
    
    unless gallery_name
      images = Album.find_by_s_album_id(6492555).images
    end
    @images = images
  end
  
  def refresh
    SmugmugImporter.get_all()
  end
end
