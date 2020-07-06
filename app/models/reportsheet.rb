class Reportsheet < ApplicationRecord
  belongs_to :user
  has_many :positions, dependent: :destroy

  def add_geoposition(lats, lons, recdates, uid, rsid)
    position = Position.where("user_id=?", uid).last
    if position != nil
      (0..lats.count-1).each do |i|
        if recdates[i] >= position.recdate
          Position.create(reportsheet_id: rsid, lat: lats[i], lon: lons[i], recdate: recdates[i], user_id: uid)
        end
      end
    else
      (0..lats.count-1).each do |i|
          Position.create(reportsheet_id: rsid, lat: lats[i], lon: lons[i], recdate: recdates[i], user_id: uid)
      end
    end
  end
end
