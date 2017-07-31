class AddFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :firstname, :string
    add_column :users, :surname, :string
    add_column :users, :approved, :boolean, :default => false
  end
end
