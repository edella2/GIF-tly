helpers do

	def current_user
		@current_user ||= User.where(id: session[:id]).first if session[:id]
	end

  def logged_in
    current_user.nil? == false
  end

  def allow_edit_message(message)
    p message
    if session[:id] == message.from.id
      return true
    else
      return false
    end
  end

  def allow_edit_user(user)
    if session[:id] == user.id
      return true
    else
      return false
    end
  end
end
