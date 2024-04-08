class Property < ApplicationRecord
  #name,headline,description, address_1,city, state,country
  validates :name,:headline,:description,:address_1,:state,:city,:country, presence: true
  monetize :price_cents, allow_nil: true
  has_many_attached :images
  has_many :reviews,dependent: :destroy

  has_many :whislists, dependent: :destroy
  has_many :whislisted_users, through: :whislists,source: :user,dependent: :destroy

  has_many :reservations ,dependent: :destroy
  has_many :reserved_users,through: :reservations,source: :user,dependent: :destroy


  def  update_average_rating
    average_rating = reviews.average(:overall_rating)
    update_column(:average_overall_rating,average_rating)
  end

  def whistlisted_by?(user = nil)
    return if user.nil?
    whislisted_users.include?(user)
  end
end
