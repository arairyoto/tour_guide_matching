class RenameFromColumnToAsks < ActiveRecord::Migration
  def change
    rename_column :asks, :to, :time_to
    rename_column :asks, :from, :time_from
    rename_column :bids, :to, :time_to
    rename_column :bids, :from, :time_from
  end
end
