class HomeController < ApplicationController
  
  def index
    @images = Images.all
  end
end
