class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :ask_id
      t.integer :bid_id
      t.integer :rate

      t.timestamps null: false
    end
  end
end
