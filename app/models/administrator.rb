class Administrator < ApplicationRecord
  belongs_to :user
  belongs_to :line

  validates :user_id, :line_id, presence: true
end
