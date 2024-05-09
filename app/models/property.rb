class Property < ApplicationRecord
  #name,headline,description, address_1,city, state,country
  validates :name,:headline,:description,:address_1,:state,:city,:country_code,:latitude,:longitude,presence: true
  monetize :price_cents, allow_nil: true
  has_many_attached :images
  has_many :reviews,dependent: :destroy
  has_rich_text :description

  has_many :property_amenities, dependent: :destroy
  has_many :amenities,through: :property_amenities,source: :amenity,dependent: :destroy

  has_many :whislists, dependent: :destroy
  has_many :whislisted_users, through: :whislists,source: :user,dependent: :destroy

  has_many :reservations ,dependent: :destroy
  has_many :reserved_users,through: :reservations,source: :user,dependent: :destroy

  has_many :payments,through: :reservations,dependent: :destroy

  def self.with_reservations_overlap(check_in,check_out)
    where.not(id: Reservation.overlapping_reservations(check_in,check_out).pluck(:property_id))
  end

  def  update_average_rating
    average_rating = reviews.average(:overall_rating)
    update_column(:average_overall_rating,average_rating)
  end

  def average_cleanliness_rating
    reviews.average(:cleanliness_rating)
  end

  def average_accuracy_rating
    reviews.average(:accuracy_rating)
  end
  def average_check_in_rating
    reviews.average(:checkin_rating)
  end

  def average_communication_rating
    reviews.average(:communication_rating)
  end
  def average_location_rating
    reviews.average(:location_rating)
  end
  def average_value_rating
    reviews.average(:value_rating)
  end

  def whistlisted_by?(user = nil)
    return if user.nil?
    whislisted_users.include?(user)
  end

  def available_dates
    next_reservation = reservations.upcoming_reservations.first
    current_reservation = reservations.current_reservations.first

    #Case1: next -> nil && current -> nil
    #Case2: next -> available && current -> nil
    #Case3: next -> nil && current -> available
    #Case4: next -> available && current -> available

    if next_reservation.nil? && current_reservation.nil?
      Date.tomorrow.strftime('%e %b')..(Date.tomorrow+30.days).strftime('%e %b')
    elsif current_reservation.nil?
      Date.tomorrow.strftime('%e %b')..next_reservation.check_in.strftime('%e %b')
    elsif next_reservation.nil?
      current_reservation.check_out.strftime('%e %b')..(Date.tomorrow+30.days).strftime('%e %b')
    else
      current_reservation.check_out.strftime('%e %b')..next_reservation.check_in.strftime('%e %b')
    end

  end
end
