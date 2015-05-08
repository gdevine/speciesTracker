class SightingsController < ApplicationController
    
  before_action :authenticate_user!, only: [:index, :map, :new, :update, :show, :edit, :create, :destroy]
  load_and_authorize_resource
  
  def new
  end
  
  def create
    @sighting = Sighting.new(sighting_params)
    @sighting.creator = current_user
    # if user role then spotter is automatically set to be the current user
    if current_user.role == 'user'
      @sighting.spotter = current_user
    end 
    
    if @sighting.save
      flash[:link] = "Sighting created!"
      redirect_to @sighting
    else
      render 'sightings/new'
    end
  end
  
  def show
    @hash = Gmaps4rails.build_markers(@sighting) do |sighting, marker|
      marker.lat @sighting.latitude
      marker.lng @sighting.longitude
      marker.picture({
        :url => view_context.image_path("marker_blue.png"),
        :width   => 32,
        :height  => 32
      })
    end
    # add the marker for the site 
    @hash.push({:lat=>@sighting.site.centre_lat, :lng=>@sighting.site.centre_lon, :picture=>{:url=>"/assets/marker_pink.png", :width=>32, :height=>32}})
  end
  
  def edit
  end

  def update
    @sighting = Sighting.find(params[:id])
    if @sighting.update_attributes(sighting_params)
      flash[:link] = "Sighting Updated!"
      redirect_to @sighting
    else
      render 'edit'
    end
  end
  
  
  private
    def sighting_params
        if current_user.role != 'user'
          params.require(:sighting).permit(:species_id, :site_id, :datetime_sighted, :comments, :latitude, :longitude, :altitude, :spotter_id)
        else
          params.require(:sighting).permit(:species_id, :site_id, :datetime_sighted, :comments, :latitude, :longitude, :altitude)
        end
    end  
  
end
