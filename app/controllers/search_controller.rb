class SearchController < ApplicationController
  def index
    if is_search_params_present?
      redirect_to root_path
      return
    end
    @properties = Property.all

    if search_params[:country_code].present?
      @properties = Property.where(country_code:search_params[:country_code])
    end

    if search_params[:check_in].present? && search_params[:check_out].present?
      @properties = @properties.with_reservations_overlap(search_params[:check_in],search_params[:check_out])
    end
  end

  private


  def is_search_params_present?
    !search_params[:country_code].present? && !search_params[:check_in].present? && !search_params[:check_out].present?
  end
  def search_params
    params.permit(:country_code,:check_in,:check_out)
  end
end