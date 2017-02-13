class GamesController < ApplicationController

	get '/games' do
		erb :'games/games'
	end

	get '/games/:id' do
		erb :'games/show'
	end

end