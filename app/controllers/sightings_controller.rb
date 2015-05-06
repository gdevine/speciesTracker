class SightingsController < ApplicationController
    
  before_action :authenticate_user!, only: [:index, :map, :new, :update, :show, :edit, :create, :destroy]
  load_and_authorize_resource
  
  def new
  end
  
  def create
    @sighting = Sighting.new(sighting_params)
    @sighting.creator = current_user
    @sighting.spotter = current_user
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
    end
  end
  
  
  private

    def sighting_params
      params.require(:sighting).permit(:species_id, :site_id, :datetime_sighting, :comments, :latitude, :longitude, :altitude)
    end
  
end
