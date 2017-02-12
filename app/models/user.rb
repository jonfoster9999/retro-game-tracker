class User < ActiveRecord::Base
	has_secure_password
	validates :username, presence: true
	validates :email, presence: true
	has_many :user_games
	has_many :user_consoles
	has_many :consoles, through: :user_consoles
	has_many :games, through: :user_games
end