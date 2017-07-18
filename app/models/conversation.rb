class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  belongs_to :sender, foreign_key: :sender_id, class_name: User
  belongs_to :recipient, foreign_key: :recipient_id, class_name: User

  validates :sender_id, uniqueness: { scope: :recipient_id }

  scope :between, -> (sender_id, recipient_id) do
    where(sender_id: sender_id, recipient_id: recipient_id).or(
      where(sender_id: recipient_id, recipient_id: sender_id)
    )
  end

  def self.get(sender_id, recipient_id)
    conversation = between(sender_id, recipient_id).first
    return conversation if conversation.present?

    create(sender_id: sender_id, recipient_id: recipient_id)
  end

  def opposed_user(user)
    user == recipient ? sender : recipient
  end

  def read_by_recipient(user, conversation)
    conversation.messages.each do |message|
      # IF USER THAT SEES THE MESSAGE IS NOT THE CREATOR OF THE MESSAGE AND HAS NOT SEEN IT...
      if user.id != message.user_id && message.read_status == false
        # ...MARK THE MESSAGE AS READ
        message.read_status = true
        message.save
      end
    end
  end
end
