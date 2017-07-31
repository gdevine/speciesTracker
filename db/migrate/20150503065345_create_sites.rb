class CreateSites < ActiveRecord::Migration[5.0]
  def change
    create_table :sites do |t|
      t.string :name
      t.string :street
      t.string :suburb
      t.text :comments
      t.float :centre_lat
      t.float :centre_lon
      t.float :centre_alt

      t.timestamps
    end
    add_index :sites, [:name]
  end
end
