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
		if current_user == User.find_by_slug(params[:slug])
			@consoles = Console.all
			@user = User.find_by_slug(params[:slug])
			erb :'users/editconsoles'
		else
			erb :'users/unauthorized'
		end
	end

	post '/users/:slug/editconsoles' do
		
		@user = User.find_by_slug(params[:slug])
		@user.consoles.clear
		if params[:console_name] != ""
			name = params[:console_name]
			console = Console.new(:name => name)
			console = Console.find_by(:name => console.name) || console
			console.save
			@user.consoles << console
			@user.save
		end
		if consoles = params[:user][:console_ids]
			consoles.each do |console_id|
				@user.consoles << Console.find(console_id)
			end
			@user.save
		end
		redirect "/users/#{@user.slug}"

	end

	get '/users/:slug/editgames' do
		if current_user == User.find_by_slug(params[:slug])
			@games = Game.all
			@user = User.find_by_slug(params[:slug])
			@consoles = Console.all
			erb :'users/editgames'
		else
			erb :'users/unauthorized'
		end
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