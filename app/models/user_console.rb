class UserConsole < ActiveRecord::Base
	belongs_to :user
	belongs_to :console
end