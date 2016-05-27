require 'dm-core'
require 'dm-migrations'
require './main.rb'

class Student   #defining the class and properties that correspond to the table and columns
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :studid, Integer
  property :category, Text
  property :major, Text 
  
end

DataMapper.finalize

#Student.auto_migrate!  #use this auto migrate for the 1st time when setting up the schema

get '/students' do    #checks the logged user before showing students
   if session[:admin]
    @stud = Student.all
    erb :students
  else
   redirect to("/login")
  end
end


get '/students/new' do   #Routehanlder for creating a new student
  @stud = Student.new
  erb :new_student
  end


get '/students/:id' do   #Routehandler for showing a particular student based on id
  @stud = Student.get(params[:id])
  erb :show_student
end

get '/students/:id/edit' do    #Routehandler for editing a particular student based on id
 @stud = Student.get(params[:id])
 erb :edit_student
end

post '/students' do      #Routehandler for showing students
  stud = Student.create(params[:stud])
  redirect to("/students/#{stud.id}")
end

put '/students/:id' do    #Routehandler for showing the updated details of a student
    stud = Student.get(params[:id])
    stud.update(params[:stud])
    redirect to("/students/#{stud.id}")
end

delete '/students/:id' do   #Routehandler for deleting a student based on id
  Student.get(params[:id]).destroy
  redirect to('/students')
end

not_found do   #Customised error message
  erb :not_found
end

