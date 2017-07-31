class CreateSightings < ActiveRecord::Migration[5.0]
  def change
    create_table :sightings do |t|
      t.datetime :datetime_sighted
      t.integer :species_id
      t.integer :site_id
      t.float :latitude
      t.float :longitude
      t.float :altitude
      t.text :comments
      t.integer :spotter_id
      t.integer :creator_id

      t.timestamps
    end
    # add_index :sightings, [:site_id, :species_id, :spotter_id, :creator_id], :name => 'create_site'
    add_index :sightings, :site_id
    add_index :sightings, :species_id
    add_index :sightings, :spotter_id
    add_index :sightings, :creator_id
  end
end
