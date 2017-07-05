class ChangeDatatypeFromOfAsks < ActiveRecord::Migration
  def change
    change_column :asks, :from, :timestamps
    change_column :asks, :to, :timestamps
    change_column :bids, :from, :timestamps
    change_column :bids, :to, :timestamps
  end
end
