class Line < ApplicationRecord
  has_many :appointments
  has_many :administrators
  belongs_to :user

  validates :title, :location, :start_time, :avg_service_time, presence: true
  validates :avg_service_time, numericality: { only_integer: true }

  # SEARCH BAR CONFIGURATION
  include PgSearch
  pg_search_scope :line_search, against: [ :title, :location, :organization_name ],
  using: {tsearch: {prefix: true, any_word: true}}

  has_attachment :photo
end
