class Console < ActiveRecord::Base
	has_many :games
	has_many :user_consoles
	has_many :users, through: :user_consoles
end