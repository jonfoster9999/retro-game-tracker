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
		erb :'users/editgames'
	end


end