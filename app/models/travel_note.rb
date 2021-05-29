class TravelNote < ApplicationRecord
  paginates_per 5
  belongs_to :travaler, class_name: "User"

  # validations
  validates :city, presence: { message: 'City is required' }
  validates :body, length: { in: 10..500, message: "Your note must have between 10 to 500 words!" }
end
