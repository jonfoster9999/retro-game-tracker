class CreateUserConsoles < ActiveRecord::Migration[5.0]
  def change
  	create_table :user_consoles do |t|
  		t.integer :user_id
  		t.integer :console_id
  	end
  end
end
