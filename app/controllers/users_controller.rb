class UsersController < ApplicationController



	get '/users' do
		if logged_in?
			@user = User.find(session[:id])
			@users = User.all
			erb :'users/index'
		else
			redirect '/login'
		end
	end

	get '/users/:slug' do
		@user = User.find_by_slug(params[:slug])
		erb :'users/show'
	end

	get '/users/:slug/editconsoles' do
		erb :'users/editconsoles'
	end

	get '/users/:slug/editgames' do
		@games = Game.all
		@user = User.find_by_slug(params[:slug])
		@consoles = Console.all
		erb :'users/editgames'
	end

	post '/users/:slug/editgames' do
		@user = User.find_by_slug(params[:slug])
		@user.games.clear
		if params[:user][:new_game_name] != "" && params[:user][:new_game_year] != ""
			name = params[:user][:new_game_name]
			year = params[:user][:new_game_year].to_i
			game = Game.new(:name => name, :year => year)
			game.console = Console.find(params[:user][:new_game_console_id])
			game = Game.find_by(:name => game.name) || game
			game.save
			@user.games << game
			@user.save
		end

		if games = params[:user][:game_ids]
			games.each do |game|
				@user.games << Game.find(game)
			end
			@user.save
		end
		redirect "/users/#{@user.slug}"
	end
end