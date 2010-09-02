class HomeController < ApplicationController
  
  def index
    get_images
  end

  def images
    get_images
    render :partial => "home/hidden_images", :locals => {:images => @images}
  end
  
  def refresh
    SmugmugImporter.get_all()
  end
  
  def get_images
    gallery_name = params[:id]
    images = []
    if gallery_name
      images = Album.find_by_s_album_id(gallery_name.to_i).images
    end
    
    unless gallery_name
      images = Album.find_by_s_album_id(13417128).images
    end
    @images = images
  end
end
