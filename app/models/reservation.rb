class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :property

  has_one :payment,dependent: :destroy
  has_one :review,dependent: :destroy

  validates :check_in,:check_out,presence: true

  scope :upcoming_reservations,->{where("check_in > ?",Date.today).order(:check_in)}
  scope :current_reservations,->{where("check_out > ?",Date.today).where("check_in < ?",Date.today).order(:check_out)}
  scope :overlapping_reservations, -> (check_in,check_out){
    where("(check_in < ? AND check_out > ?) OR
           (check_in < ? AND check_out > ?) OR
           (check_in > ? AND check_out < ?) OR
           (check_in < ? AND check_out > ?)",
          check_in,check_in,check_out,check_out,check_in,check_out,check_in,check_out)
  }

end
