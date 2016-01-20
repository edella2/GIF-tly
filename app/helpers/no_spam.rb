helpers do
  def no_spam(user_to)
    count = Message.where(to_number: user_to.phone_number).select{ |message| message.created_at > DateTime.now - 1}.count
    if count < 2
      return true
    else
      return false
    end

  end
end

# User.where(phone_number: Message.last.to_number).each do |user|


# end

