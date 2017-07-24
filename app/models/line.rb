class Line < ApplicationRecord
  has_many :appointments, dependent: :destroy
  has_many :administrators, dependent: :destroy
  belongs_to :user

  validates :title, :location, :start_time, :avg_service_time, presence: true
  validates :avg_service_time, numericality: { only_integer: true }

  # CARRIERWAVE CONFIG
  mount_uploader :photo, PhotoUploader

  # SEARCH BAR CONFIG
  include PgSearch
  pg_search_scope :line_search, against: [ :title, :location, :organization_name ],
  using: {tsearch: {prefix: true, any_word: true}}

  # GEOLOCATION CONFIG
  geocoded_by :location
  after_validation :geocode, if: :location_changed?
end
