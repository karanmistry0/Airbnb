module Owner
  class PropertiesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_property,only: [:edit,:update,:update_location,:update_amenities,:remove_images,:add_images,:destroy]
    def index
      @properties = current_user.properties.order(created_at: :desc)
    end

    def new
      @property = Property.new
    end

    def create
      @property = current_user.properties.create!(property_params)
      redirect_to edit_owner_property_path(@property),notice: "Property added successfully"

    end
    def update
      if @property.update!(property_params)
        redirect_to edit_owner_property_path, notice: "Property updated successfully"
      else
        redirect_to edit_owner_property_path,alert: "Unable to update property"
      end
    end


    def update_location
      if @property.update!(location_params)
        redirect_to edit_owner_property_path, notice: "Location updated successfully"
      else
        redirect_to edit_owner_property_path,alert: "Unable to update location"
      end
    end
    def update_amenities
      if @property.update!(amenities_params)
        redirect_to edit_owner_property_path, notice: "Amenities updated successfully"
      else
        redirect_to edit_owner_property_path,alert: "Unable to update amenities"
      end
    end

    def remove_images
      image = @property.images.find(params[:image_id])
      if image.destroy!
        redirect_to edit_owner_property_path, notice: "Image deleted successfully"
      else
        redirect_to edit_owner_property_path,alert: "Unable to delete image"
      end
    end

    def add_images
      if params[:property][:images].present?
        @property.images.attach(params[:property][:images])
        redirect_to edit_owner_property_path,notice: :"Images added successfully"
      else
        redirect_to edit_owner_property_path,notice: :"Unable to add image"
      end
    end

    def destroy
      @property.destroy
      redirect_to owner_properties_path,alert: "#{@property.name}. Deleted successfully."
    end


    private
    def set_property
      @property = current_user.properties.find(params[:id])
    end

    def location_params
      params.require(:property).permit(:latitude,:longitude)
    end
    def amenities_params
      params.require(:property).permit(:amenity_ids => [])
    end
    def property_params
      params.require(:property).permit(
      :name,
      :headline,
      :description,
      :address_1,
      :address_2,
      :city,
      :state,
      :country_code,
      :price,
      :guests,
      :bedrooms,
      :bed,
      :bathroom
      )
    end
  end
end