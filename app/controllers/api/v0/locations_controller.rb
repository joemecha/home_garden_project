# frozen_string_literal: true

class Api::V0::LocationsController < Api::V0::BaseController
  before_action :set_garden
  before_action :set_location, only: %i[show]

  def index
    if @garden.locations.blank?
      render json: { message: 'You currently have no locations.'}
    else
      render json: LocationSerializer.new(@garden.locations)
    end
  end

  def show
    if @location.nil?
      render json: { errors: "Cannot find location with ID #{params[:id]}" }, status: :not_found
    else
      render json: LocationSerializer.new(@location)
    end
  end

  def create
    if params[:name].blank?
      render json: { errors: 'Name cannot be blank' }, status: :bad_request
    else
      location = Location.create(location_params)
      render json: LocationSerializer.new(location), status: :created
    end
  end

  private

  def location_params
    params.require(:location).permit(:name, :size, :irrigated)
  end

  def set_garden
    @garden = Garden.find_by(id: params[:garden_id])
    render json: { errors: "Cannot find garden with ID #{params[:garden_id]}" }, status: :not_found if @garden.nil? || @garden.user_id != @current_user.id
  end

  def set_location
    @location = Location.find_by(id: params[:id])
  end
end
