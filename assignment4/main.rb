require 'sinatra'
require 'sinatra/reloader' if development?
require 'erb'
require './student'

configure do   #Enabling session and required config settings
  enable :sessions
  set :username, 'keerthana'
  set :password, 'shroff'
  set :admin, 'false'
end

configure :development do  #Database set up
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/studentinfo.db")
end
=begin
configure :production do
  DataMapper.setup(:default, ENV['DATABASE_URL'])
end
=end

#Login implementation
get '/login' do
  erb :login
 end

post '/login' do
 if params[:username] == settings.username &&  params[:password] == settings.password 
             session[:admin] = true
             redirect to ('/students')
     else   
      erb :login   
      'Enter correct credentials'

 end
end

#Logout implementation
get '/logout' do
   session[:admin] = false

   redirect to ('/') 
end

#Home page route
get '/' do
 erb :home
end

#about page route
get '/about' do
 erb :about
end

#contact page route
get '/contact' do
 erb :contact
end

#linking styles
get('/styles.css'){ scss :styles }

