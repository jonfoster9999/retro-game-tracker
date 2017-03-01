class Game < ActiveRecord::Base
	belongs_to :console
	has_many :user_games
	has_many :users, through: :user_games

	validates :name, presence: true
	validates :year, presence: true

	def self.make_game_hash(games)
      gamehash = {}
      games.each do |game|
        #sets the value of the gamehash["console name"] to either an empty array
        #(first iteration),  or it's current state from previous iterations
        gamehash["#{game.console.name}"] = gamehash["#{game.console.name}"] || []
        #builds a new object for a game and inserts it into this arrays
        gamehash["#{game.console.name}"] << {:name => game.name, :year => game.year, :id => game.id}
      end
      gamehash.each do |key, value|
        #gets rid of any duplicate game entries
        gamehash["#{key}"] = value.uniq
      end
    end
end