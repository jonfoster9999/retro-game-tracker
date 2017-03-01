class SessionController < ApplicationController

	get '/login' do
	  	if !logged_in?
			erb :'users/login'
	  	else
	    	redirect '/users'
	  	end
	end

	post '/login' do
	  	@user = User.find_by(:username => params[:username])
	  	if @user && @user.authenticate(params[:password])
	    	session[:user_id] = @user.id
	    	redirect '/users'
	  	else
	    	@failure = "Invalid Login Information"
	    	erb :'users/login'
		end
	end


	get '/logout' do
		@user = current_user
	  	if @user 
	    	session.clear
	    	redirect '/login'
	  	else
	    	redirect '/'
	 	end
	end
end