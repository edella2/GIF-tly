helpers do
  def omg_text(user_text)
      text = user_text
      text_array = text.split(" ")
      translated_string = []
      website_friendly = text_array.join("%20")
      translated_string = RestClient.get "young-peak-8904.herokuapp.com/omg_api/#{website_friendly}"
      return translated_string
  end
end

#omg text body
# body: omg_text("Merry XMAS from #{@user_from.username}") + "! link: #{@message.url}"

#body normal
# body: "Merry XMAS from #{@user_from.username} link: #{@message.url}"