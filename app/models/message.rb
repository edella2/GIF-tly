class Message < ActiveRecord::Base
  belongs_to :from, foreign_key: :user_from, class_name: "User"
  belongs_to :to, foreign_key: :user_to, class_name: "User"
end
