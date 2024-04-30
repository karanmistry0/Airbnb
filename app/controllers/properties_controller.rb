class PropertiesController < ApplicationController
  def show
    @property = Property.includes(:reviews).find(params[:id])

    @overall_rating_count = @property.reviews.group('ROUND(overall_rating)').count.transform_keys(&:to_i)
    @overall_rating_count.default = 0
    upcoming_reservations = @property.reservations.upcoming_reservations.pluck(:check_in,:check_out)
    @formatted_date = upcoming_reservations.map{|reservation| [reservation[0].to_s,(reservation[1]-1.days).to_s]}
  end
end