class Match < ActiveRecord::Base
    belongs_to :ask
    belongs_to :bid
end
