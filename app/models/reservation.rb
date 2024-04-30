class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :property

  has_one :payment
  has_one :review

  validates :check_in,:check_out,presence: true

  scope :upcoming_reservations,->{where("check_in > ?",Date.today).order(:check_in)}
  scope :current_reservations,->{where("check_out > ?",Date.today).where("check_in < ?",Date.today).order(:check_out)}
end
