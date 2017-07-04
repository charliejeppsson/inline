class Line < ApplicationRecord
  has_many :appointments
  belongs_to :user

  validates :title, :location, :start_time, :avg_service_time, :user_id, presence: true
  validates :avg_service_time, numericality: { only_integer: true }
end
