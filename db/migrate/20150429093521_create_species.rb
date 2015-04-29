class CreateSpecies < ActiveRecord::Migration
  def change
    create_table :species do |t|
      t.string :genus
      t.string :species
      t.string :common_name
      t.text :description

      t.timestamps null: false
    end
    add_index :species, [:genus]
  end
end
