class SightingsController < ApplicationController
    
  before_action :authenticate_user!, only: [:index, :map, :new, :update, :show, :edit, :create, :destroy]
  load_and_authorize_resource
    
  def index
  end
  
  def map 
    @hash = Gmaps4rails.build_markers(@sightings) do |sighting, marker|
      marker.lat sighting.primary_lat
      marker.lng sighting.primary_lon
      marker.picture({
        :url => view_context.image_path("marker_plant.png"),
        :width   => 32,
        :height  => 32
      })
      marker.infowindow render_to_string(:partial => "sightings/info_window", :locals => { :sighting => sighting})
    end
  end

  def new
    @sighting = Sighting.new
    @sighting.datetime_sighted = DateTime.now
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
      marker.lat @sighting.primary_lat
      marker.lng @sighting.primary_lon
      marker.picture({
        :url => view_context.image_path("marker_plant.png"),
        :width   => 32,
        :height  => 32
      })
    end
    # add the marker for the site if given
    if !@sighting.site.nil?
      @hash.push({:lat=>@sighting.site.centre_lat, :lng=>@sighting.site.centre_lon, :picture=>{:url=>view_context.image_path("marker_pink.png"), :width=>32, :height=>32}})
    end
    
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
  
  def destroy
    @sighting.destroy
    flash[:link] = "Sighting Deleted!"
    redirect_to sightings_path
  end
  
  
  private
    def sighting_params
        if current_user.role != 'user'
          params.require(:sighting).permit(:species_id, :site_id, :datetime_sighted, :comments, :photo, :latitude, :longitude, :altitude, :spotter_id, :plant_ages_seen, :dom_flower_stage, :dom_pod_stage, :healthy_flowers, :healthy_pods, :adult_abundance)
        else
          params.require(:sighting).permit(:species_id, :site_id, :datetime_sighted, :comments, :photo, :latitude, :longitude, :altitude, :plant_ages_seen, :dom_flower_stage, :dom_pod_stage, :healthy_flowers, :healthy_pods, :adult_abundance)
        end
    end  
  
end
