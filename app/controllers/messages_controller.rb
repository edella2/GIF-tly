#show all users
get '/messages' do
  @messages = Message.all
  erb :'messages/index'
end

#new message form
get '/messages/new' do
  if logged_in
    erb :'messages/new'
  else
    redirect '/messages'
  end
end

#create new message
post '/messages' do
  redirect '/sessions/new' if session[:id].nil?
  @user_to = User.find_by(username: params[:user_to])
  @new_message = Message.new(url: params[:url], img_url: params[:img_url], user_from: current_user.id)
  if @new_message.save
    erb :'/partials/_gif_image', layout: false
  else
    redirect '/messages/new'
  end
end

# user_to and user_from cannot be created > 1 day
post '/messages/send' do
  if params[:user_to]
  redirect '/sessions/new' if session[:id].nil?
    @user_to = User.find_by(username: params[:user_to])
  else
    @user_to = User.first
    @user_to.update(phone_number: params[:phone_number])
  end



  @user_from = User.find(current_user.id)
  @message = @user_from.messages.last
  twil = TwilioMessager.new
  if no_spam(@user_to) && @message.update(body: "Merry XMAS from #{@user_from.username} link: #{@message.url}", user_to: @user_to.id, from_number: @user_from.phone_number, to_number: @user_to.phone_number)
    twil.make_call({body: @message.body, to: @user_to.phone_number, media_url: @message.img_url})
    redirect "/users/#{current_user.id}"
  else
    redirect "/users/#{current_user.id}"
  end
end

#get edit page
get '/messages/:id/edit' do
  @message = Message.find(params[:id])
  if allow_edit_message(@message)
    erb :'/messages/edit'
  else
    redirect "/messages/#{params[:id]}"
  end
end

#show a message
get '/messages/:id' do
  @message = Message.find(params[:id])
  erb :'/messages/show'
end

#submit message edit
put '/messages/:id' do
  @message = Message.find(params[:id])
  @message.update(body: params[:body], title: params[:title])
  redirect "messages/#{@message.id}"
end

#delete message
delete '/messages/:id' do
  if params[:id] == "undefined"
    return "first message"
  end
  @message = Message.find(params[:id])
  if allow_edit_message(@message) && @message.to.nil?
    @message.destroy
  else
    redirect "/messages/#{params[:id]}"
  end
end


# Giphy API request
post '/giphy' do
  giphy = RestClient.get "http://api.giphy.com/v1/gifs/random?api_key=" + ENV['GIPHY_API_KEY'] + "&tag=christmas&rating=pg-13"
  giphy
end
