class ApplicationController < Sinatra::Base
  
  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
  	erb :'index'
  end

  get '/login' do
  	erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect '/users'
    else
      redirect '/login'
    end

  end

  get '/signup' do
  	erb :'users/signup'
  end

  post '/signup' do 
  	@user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
  	if @user.save
  		session[:id] = @user.id
  		redirect '/users'
  	else
  		redirect '/signup'
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


  helpers do
  	def logged_in?
  		!!session[:id]
  	end

  	def current_user
  		User.find_by(:id => session[:id])
	end

  end

end