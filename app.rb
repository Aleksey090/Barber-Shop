require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

configure do
	@db = SQLite3::Database.new 'databaseBarberShop.db'
	@db.execute 'CREATE TABLE IF NOT EXISTS 
		"users" 
			(
				"id" INTEGER PRIMARY KEY AUTOINCREMENT, 
				"username" TEXT, 
				"phone" TEXT, 
				"date_stamp" TEXT, 
				"color" TEXT, 
				"barber" TEXT
			)'
end

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
	# @error = "Error"
	erb :about
end

get '/visit' do
	erb :visit
end

post '/visit' do

	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@color = params[:color]
	@barber = params[:barber]

				# -----REFACTORING 01-------
		# if @username == ''
		# 	@error = 'Enter name'
		# end

		# if @phone == ''
		# 	@error = 'Enter phone'
		# end

		# if @datetime == ''
		# 	@error = 'Enter time'
		# end

		# if @error != ''
		# 	return erb :visit
		# end

				# -----REFACTORING 02-------
		hh = { :username => 'Enter name',
				:phone => 'Enter phone',
				:datetime => 'Enter time' }
		
			@error = hh.select {|key,_| params[key] == ''}.values.join(' & ')

				if @error != ''
					return erb :visit
				end

				# -----REFACTORING 03-------
		# hh.each do |key, value|
		# 	if params[key] == ''
		# 		@error = [value]
		# 		return erb :visit
		# 	end
		# end



	erb "OK, your name: #{@username}, your phone: #{@phone}, date: #{@datetime} and your color: #{@color}"

end
