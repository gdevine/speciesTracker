class AddFieldsToSightings < ActiveRecord::Migration
  def change
    add_column :sightings, :plant_ages_seen, :string
    add_column :sightings, :dom_flower_stage, :string
    add_column :sightings, :dom_pod_stage, :string
    add_column :sightings, :healthy_flowers, :string
    add_column :sightings, :healthy_pods, :string
    add_column :sightings, :adult_abundance, :integer
  end
end
