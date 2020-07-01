class Position < ApplicationRecord
  validates :recdate, presence: true
  validates :lat, presence: true
  validates :lon, presence: true
  validates :user_id, presence: true
  belongs_to :user
  belongs_to :reportsheet
  default_scope -> { order(recdate: :desc)}
end
