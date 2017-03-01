class UsersController < ApplicationController


	get '/users' do
		if logged_in?
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
		if current_user == (@user = User.find_by_slug(params[:slug]))
			@consoles = Console.all
			erb :'users/editconsoles'
		else
			erb :'users/unauthorized'
		end
	end

	post '/users/:slug/editconsoles' do
		
		@user = User.find_by_slug(params[:slug])
		@user.consoles.clear
		# If a user entered a console name into the field, enter this block
		if params[:console_name] != ""
			# If a user enterd the name of a console that already exists, find it, so it's not 
			# created twice.
			console = Console.find_or_create_by(:name => params[:console_name])
			@user.consoles << console
			@user.save
		end
		# Needs a conditional if every field is blank and a user hits submit
		if params[:user]
			if consoles = params[:user][:console_ids]
				consoles.each do |console_id|
					@user.consoles << Console.find(console_id)
				end
				@user.save
			end
		end
		redirect "/users/#{@user.slug}"
	end

	get '/users/:slug/editgames' do
		# check if the logged in user is the user that's trying to access the edit page

		if current_user == (@user = User.find_by_slug(params[:slug]))
			@games = Game.all
			@consoles = Console.all
			erb :'users/editgames'
		else
		# if not, send them to the unauthorized page

			erb :'users/unauthorized'
		end
	end

	post '/users/:slug/editgames' do
		@user = User.find_by_slug(params[:slug])
		@user.games.clear
		if params[:user][:new_game_name] != "" && params[:user][:new_game_year] != ""
			game = Game.find_by(:name => params[:user][:new_game_name]) || Game.create(:name => params[:user][:new_game_name], :year =>  params[:user][:new_game_year].to_i, :console => Console.find(params[:user][:new_game_console_id]))
			@user.games << game
			@user.save
		end
		if games = params[:user][:game_ids]
			games.each do |game_id|
				@user.games << Game.find(game_id)
			end
			@user.save
		end
		redirect "/users/#{@user.slug}"
	end
end