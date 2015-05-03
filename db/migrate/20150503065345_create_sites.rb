class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.string :street
      t.string :suburb
      t.text :comments
      t.float :centre_lat
      t.float :centre_lon
      t.float :centre_alt

      t.timestamps null: false
    end
    add_index :sites, [:name]
  end
end
