require './config/environment'


use Rack::MethodOverride
use ConsolesController
use UsersController
use GamesController
run ApplicationController