class RegistrationController < ApplicationController
get '/signup' do
      if !logged_in?
    	 erb :'users/signup'
      else
        redirect '/users'
      end
    end

    post '/signup' do 
    	@user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    	if @user.save
    		session[:user_id] = @user.id
    		redirect '/users'
    	else
        flash[:message] = user.errors.full_messages
    		redirect '/signup'
    	end
    end
end