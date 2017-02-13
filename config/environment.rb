ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)

  configure do
    set :public_folder , Proc.new {File.join(root,"../public")}
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

require_all 'app'