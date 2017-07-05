class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
      t.datetime :from
      t.datetime :to
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
