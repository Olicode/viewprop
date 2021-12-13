class Conversation < ApplicationRecord
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  has_many :messages

  def other_user(user)
    if user.id == sender_id
      User.find(receiver_id)
    else
      User.find(sender_id)
    end
  end
end
