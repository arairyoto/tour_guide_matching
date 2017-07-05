class AddMatchIdToAsk < ActiveRecord::Migration
  def change
    add_column :asks, :match_id, :integer
  end
end
