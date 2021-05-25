class TravelNote < ApplicationRecord
  paginates_per 5
  belongs_to :travaler, class_name: "User"
end
