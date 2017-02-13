class Game < ActiveRecord::Base
	belongs_to :console
	has_many :user_games
	has_many :users, through: :user_games

	validates :name, presence: true
	validates :year, presence: true
end