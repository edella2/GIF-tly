#show all users
get '/users' do
	@users = User.all
	erb :'/users/user_index'
end

#new user form
get '/users/new' do
	erb :'/users/user_new'
end

#create new user
post '/users' do
	user = User.new(username: params[:username], email:
		params[:email], phone_number: params[:phone_number])
	user.password = params[:password]
	if user.save
		session[:id] = user.id
		redirect '/'
	else
		# status 400
		# flash[:errors] = user.errors.full_messages
		redirect '/users/new'
	end
end

#get edit page
get '/users/:id/edit' do
	@user = User.find(params[:id])
	if allow_edit_user(@user)
		erb :'/users/user_edit'
	else
		redirect '/'
	end
end

# guest user route
get '/users/1' do
	redirect '/'
end

#show a user
get '/users/:id' do
	@user = User.find(params[:id])
	@recieved_messages = Message.where(user_to: params[:id])
	@sent_messages = Message.where(user_from: params[:id])
	erb :'/users/user_show'
end

#submit user edit
put '/users/:id' do
	user = User.find(params[:id])
	user.username = params[:username]
	user.email = params[:email]
	if user.save
		redirect '/'
	else
		# flash[:errors] = user.errors.full_messages
		redirect "/users/#{current_user.id}/edit"
	end
end

#delete user
delete '/users/:id' do
	User.find(params[:id]).destroy
	session[:id] = nil
	current_user = nil
end


