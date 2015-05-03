class SpeciesController < ApplicationController
  
  before_action :authenticate_user!, only: [:index, :new, :update, :show, :edit, :create, :destroy]
  load_and_authorize_resource
  
  def index
  end

  def new
  end   
  
  def create
    @species = Species.new(species_params)
    if @species.save
      flash[:link] = "Species created!"
      redirect_to @species
    else
      render 'species/new'
    end
  end
    
  def show
  end
  
  def edit
  end

  def update
    @species = Species.find(params[:id])
    if @species.update_attributes(species_params)
      flash[:link] = "Species Updated!"
      redirect_to @species
    else
      render 'edit'
    end
  end
  
  def destroy
    @species.destroy
    flash[:link] = "Species Deleted!"
    redirect_to species_index_path
  end
  
  private

    def species_params
      params.require(:species).permit(:genus, :species, :common_name, :description)
    end


end

