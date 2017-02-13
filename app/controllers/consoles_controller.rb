class ConsolesController < ApplicationController

	get '/consoles' do
		@consoles = Console.all
		erb :'consoles/consoles'
	end

	get '/consoles/new' do
		erb :'consoles/new'
	end

	post '/consoles' do
		name = params[:new_console_name]
		console = Console.new(:name => name)
		if console.save
			@message = "#{console.name} was created."
			redirect '/consoles'
		else
			redirect '/consoles/new'
		end
	end

	get '/consoles/:id/edit' do
		@console = Console.find(params[:id])
		erb :'consoles/edit'
	end

	get '/consoles/:id' do
		@console = Console.find(params[:id])
		@games = Game.where(:console_id => @console.id)
		erb :'consoles/show'
	end

	patch '/consoles/:id' do
		@console = Console.find(params[:id])
		@console.name = params[:console_name]
		if @console.save
			@message = "#{@console.name} has been successfully updated."
			@consoles = Console.all
			erb :'consoles/consoles'
		else
			redirect '/consoles/<%= @console.id %>/edit'
		end
	end

	delete '/consoles/:id/delete' do
		@console = Console.find(params[:id])
		Game.where(:console_id => @console.id).destroy_all
		@name = @console.name
		@console.delete
		@consoles = Console.all
		@message = "#{@name} has been deleted."
		erb :'consoles/consoles'
	end
end