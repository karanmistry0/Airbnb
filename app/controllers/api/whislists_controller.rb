module Api
  class WhislistsController < ApplicationController

    protect_from_forgery with: :null_session
    def create
      whislist = Whislist.create!(whislist_params)

      respond_to do |format|
        format.json do
          render json: whislist.to_json, status: :ok
        end
      end

    end
    def destroy
      whislist = Whislist.find(params[:id])
      whislist.destroy()
      respond_to do |format|
        format.json do
          render json: whislist.to_json, status: 204
        end
      end
    end

    private
    def whislist_params
      params.permit(:user_id,:property_id)
    end
  end
end