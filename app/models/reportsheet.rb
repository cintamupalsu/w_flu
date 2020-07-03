class Reportsheet < ApplicationRecord
  belongs_to :user
  has_many :positions, dependent: :destroy

  def add_geoposition(idoStr, memoStr)

  end
end
