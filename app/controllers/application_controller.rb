class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
  	"Hello World"
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