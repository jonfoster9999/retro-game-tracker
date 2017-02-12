class CreateGames < ActiveRecord::Migration[5.0]
  def change
  	create_table :games do |t|
  		t.string :name
  		t.integer :year
  		t.integer :console_id
  	end
  end
end
