#create new session page
get '/login' do
	erb :'/sessions/session_new'
end


#login to session
post '/sessions' do
	user = User.find_by(email: params[:email])
	if user && user.password = params[:password]
		session[:id] = user.id
		redirect '/'
	else
		# flash[:errors] = ['Incorrect Username or Password']
		status 400
		redirect '/login'
	end
end


#delete session
get '/sessions/:id' do
	current_user = nil
	session[:id] = nil
	erb :'/partials/_log_out'
end


# get '/gotogoogle' do

#  redirect "https://accounts.google.com/o/oauth2/auth?scope=email%20profile&state=b&redirect_uri=#{ENV["HOST"]}/oauthcallback&response_type=code&client_id=#{ENV["GOOGLE_CLIENT_ID"]}"
# end

# get '/oauthcallback' do
#   p params
#   body = {
#     code: params[:code],
#     client_id: ENV["GOOGLE_CLIENT_ID"],
#     client_secret: ENV["GOOGLE_SECRET"],
#     redirect_uri: "#{ENV["HOST"]}/oauthcallback",
#     grant_type: "authorization_code"
#   }
#   p body
#   p body[:redirect_uri]
#   post_repsonse = HTTParty.post("https://accounts.google.com/o/oauth2/token", body: body)
#   me = HTTParty.get("https://www.googleapis.com/plus/v1/people/me?access_token=#{post_repsonse["access_token"]}")
#   p me
#   email = me.parsed_response["emails"].first
#   email =email["value"]
#   @user = User.find_or_create_by(email: email)
#   session[:id]= @user.id
#   redirect "/users/#{@user.id}"
# end

