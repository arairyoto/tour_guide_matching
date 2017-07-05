class Bid < ActiveRecord::Base
    geocoded_by :address
    after_validation :geocode, if: :address_changed?
    belongs_to :user
    has_one :match, dependent: :destroy
end
