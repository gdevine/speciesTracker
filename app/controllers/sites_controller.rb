class SitesController < ApplicationController

  before_action :authenticate_user!, only: [:index, :map, :new, :update, :show, :edit, :create, :destroy]
  load_and_authorize_resource

  def index
  end

  def map
    @hash = Gmaps4rails.build_markers(@sites) do |site, marker|
      marker.lat site.centre_lat
      marker.lng site.centre_lon
      marker.picture({
        :url => view_context.image_path("marker_pink.png"),
        :width   => 32,
        :height  => 32
      })
      marker.infowindow render_to_string(:partial => "sites/info_window", :locals => { :site => site})
    end
  end

  def new
  end

  def create
    @site = Site.new(site_params)
    if @site.save
      flash[:link] = "Research Site created!"
      redirect_to @site
    else
      render 'sites/new'
    end
  end

  def show
    @hash = Gmaps4rails.build_markers(@site) do |site, marker|
      marker.lat @site.centre_lat
      marker.lng @site.centre_lon
      marker.picture({
        :url => view_context.image_path("marker_pink.png"),
        :width   => 32,
        :height  => 32
      })
    end
  end

  def edit
  end

  def update
    @site = Site.find(params[:id])
    if @site.update_attributes(site_params)
      flash[:link] = "Research Site Updated!"
      redirect_to @site
    else
      render 'edit'
    end
  end

  def destroy
    @site.destroy
    flash[:link] = "Research Site Deleted!"
    redirect_to sites_path
  end

  private

    def site_params
      params.require(:site).permit(:name, :street, :suburb, :comments, :centre_lat, :centre_lon, :centre_alt)
    end

end
