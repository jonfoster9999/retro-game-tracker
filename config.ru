require './config/environment'

use Rack::MethodOverride
use ConsolesController
use UsersController
use GamesController
use RegistrationController
use SessionController
run ApplicationController