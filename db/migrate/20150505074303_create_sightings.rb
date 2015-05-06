class CreateSightings < ActiveRecord::Migration
  def change
    create_table :sightings do |t|
      t.integer :species_id
      t.datetime :datetime_sighted
      t.integer :site_id
      t.float :latitude
      t.float :longitude
      t.float :altitude
      t.text :comments
      t.integer :spotter_id
      t.integer :creator_id

      t.timestamps null: false
    end
    add_index :sightings, [:species_id, :site_id, :spotter_id, :creator_id], :name => 'create_species'
  end
end
