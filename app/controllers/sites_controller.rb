class SitesController < ApplicationController
  
  before_action :authenticate_user!, only: [:index, :map, :new, :update, :show, :edit, :create, :destroy]
  load_and_authorize_resource
  
  def index
  end
  
  def map
    @hash = Gmaps4rails.build_markers(@sites) do |site, marker|
      marker.lat site.centre_lat
      marker.lng site.centre_lon
      marker.infowindow render_to_string(:partial => "sites/info_window", :locals => { :site => site})
    end
  end
  
  def new
  end  
  
  def create
    @site = Site.new(site_params)
    if @site.save
      flash[:link] = "Site created!"
      redirect_to @site
    else
      render 'sites/new'
    end
  end

  def show
    @hash = Gmaps4rails.build_markers(@site) do |site, marker|
      marker.lat @site.centre_lat
      marker.lng @site.centre_lon
      marker.infowindow @site.name
    end
  end

  private

    def site_params
      params.require(:site).permit(:name, :street, :suburb, :comments, :centre_lat, :centre_lon, :centre_alt)
    end
  
end
