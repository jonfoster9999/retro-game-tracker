class GamesController < ApplicationController

	get '/games' do
		@games = Game.all
		erb :'games/games'
	end

	get '/games/new' do
		@consoles = Console.all
		erb :'games/new'
	end

	get '/games/:id/' do
		@game = Game.find(params[:id])
		erb :'games/show'
	end

	get '/games/:id/edit' do
		@game = Game.find(params[:id])
		@consoles = Console.all
		erb :'games/edit'
	end

	post '/games' do
		name = params[:new_game_name]
		year = params[:new_game_year]
		console = Console.find(params[:new_game_console_id])
		game = Game.new(:name => name, :year => year)
		game.console = console
		if game.save
			redirect '/games'
		else
			redirect '/games/new'
		end
	end

	delete '/games/:id/delete' do
		@game = Game.find(params[:id])
		@message = "#{@game.name} has been deleted."
		@game.delete
		@games = Game.all
		erb :'games/games'
	end

	patch '/games/:id' do
		@game = Game.find(params[:id])
		@game.name = params[:game_name]
		@game.year = params[:game_year]
		@game.console = Console.find(params[:game_console_id])
		if @game.save
			@message = "#{@game.name} has been updated."
			@games = Game.all
			erb :'games/games'
		else
			redirect "/games/#{@game.id}/edit"
		end

	end

end