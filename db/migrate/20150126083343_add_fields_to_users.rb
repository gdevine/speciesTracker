class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :firstname, :string
    add_column :users, :surname, :string
    add_column :users, :approved, :boolean, :default => false
  end
end
