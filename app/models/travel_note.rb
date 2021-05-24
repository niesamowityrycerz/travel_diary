class TravelNote < ApplicationRecord
  belongs_to :travaler, class_name: "User"
end
