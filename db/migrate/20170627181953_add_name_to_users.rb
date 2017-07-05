class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :first_language, :string
    add_column :users, :second_language, :string
    add_column :users, :third_language, :string
  end
end
