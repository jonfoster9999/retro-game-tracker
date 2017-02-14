class User < ActiveRecord::Base
	has_many :user_games
	has_many :user_consoles
	has_many :consoles, through: :user_consoles
	has_many :games, through: :user_games

	has_secure_password
	validates :username, presence: true
	validates :email, presence: true


	def slug
		self.username.parameterize
	end

	def self.find_by_slug(my_slug)
		self.all.detect do |user|
			user.slug == my_slug
		end
	end
end