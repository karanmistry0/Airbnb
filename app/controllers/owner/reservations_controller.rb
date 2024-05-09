module Owner
  class ReservationsController < ApplicationController
    def index
      @reservations = current_user.properties.map(&:reservations).flatten
    end
  end
end
