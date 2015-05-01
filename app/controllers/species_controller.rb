class SpeciesController < ApplicationController
  
  before_action :authenticate_user!, only: [:index, :new, :update, :show, :edit, :create, :destroy]
  load_and_authorize_resource
  
  def index
    # @species = Species.all
  end

  def new
  end   
  
  def create
    @species = Species.new(species_params)
    if @species.save
      flash[:success] = "Species created!"
      redirect_to @species
    else
      render 'species/new'
    end
  end
    
  def show
    @species = Species.find(params[:id])
  end
  
  def edit
    # @species = Species.find(params[:id])
  end

  def update
    @species = Species.find(params[:id])
    if @species.update_attributes(species_params)
      flash[:success] = "Species Updated!"
      redirect_to @species
    else
      render 'edit'
    end
  end
  
  private

    def species_params
      params.require(:species).permit(:genus, :species, :common_name, :description)
    end


end

