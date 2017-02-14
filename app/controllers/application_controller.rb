class ApplicationController < Sinatra::Base
  
  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    if !logged_in?
  	 erb :'index'
    else
      redirect '/users'
    end
  end

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
      session[:id] = @user.id
      redirect '/users'
    else
      @failure = "Invalid Login Information"
      erb :'users/login'
    end

  end

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
      if logged_in?
  		  User.find_by(:id => session[:id])
      end
	  end

    def make_game_hash(games)
      gamehash = {}
      games.each do |game|
        gamehash["#{game.console.name}"] = gamehash["#{game.console.name}"] || []
        gamehash["#{game.console.name}"] << {:name => game.name, :year => game.year, :id => game.id}
      end
      gamehash.each do |key, value|
        gamehash["#{key}"] = value.uniq
      end
    end

  end

end