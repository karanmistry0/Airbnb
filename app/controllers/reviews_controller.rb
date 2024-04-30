class ReviewsController < ApplicationController

  before_action :set_reservations,only: [:new,:create]


  def create
    @review = current_user.reviews.new(
      review_params.merge(
        property_id: @reservation.property_id,
        reservation_id: @reservation.id
      )
    )
    if @review.save
      redirect_to root_path,notice: "Review saved successfully"
    else
      redirect_back fallback_location: root_path, alert:"Review not saved!"
    end
  end

  private

  def set_reservations
    @reservation = Reservation.find(params[:reservation_id])
  end
  def review_params
    params.permit(
                  :content,
                  :cleanliness_rating,
                  :accuracy_rating,
                  :checkin_rating,
                  :communication_rating,
                  :location_rating,
                  :value_rating)
  end
end