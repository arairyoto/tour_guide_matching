class AddMatchIdToBid < ActiveRecord::Migration
  def change
    add_column :bids, :match_id, :integer
  end
end
