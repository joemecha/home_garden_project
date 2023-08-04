# frozen_string_literal: true

class Api::V0::LocationsController < Api::V0::BaseController
  before_action :authenticate_user!
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
    if @location.nil? || @location.garden_id != @garden.id
      render_not_found("Cannot find location with ID #{params[:id]}")
    else
      render json: LocationSerializer.new(@location)
    end
  end

  def create
    location = Location.new(location_params)

    if location.save
      render json: LocationSerializer.new(location), status: :created
    else
      render json: { errors: location.errors.full_messages }, status: :bad_request
    end
  end

  private

  def location_params
    params.require(:location).permit(:name, :size, :irrigated, :garden_id)
  end

  def set_garden
    @garden = Garden.find_by(id: params[:garden_id])
    render_not_found("Cannot find garden with ID #{params[:garden_id]}") if @garden.nil? || @garden.user_id != current_user.id
  end

  def set_location
    @location = Location.find_by(id: params[:id])
  end
end
