class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :property

  validates :check_in,:check_out,presence: true
end
