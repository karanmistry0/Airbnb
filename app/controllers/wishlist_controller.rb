class WishlistController < ApplicationController
  before_action :authenticate_user!
  def index
    @properties = current_user.whislisted_properties
  end
end