# frozen_string_literal: true

class Api::V0::CropsController < Api::V0::BaseController
  before_action :set_crop, only: %i[show]
  before_action :set_location, only: %i[index show create]

  def index
    if @location.crops.blank?
      render json: { message: 'You currently have no crops in this location.'}
    else
      render json: CropSerializer.new(@location.crops)
    end
  end

  def show
    if @crop.blank?
      render_not_found("Cannot find crop with ID #{params[:id]}")
    else
      render json: CropSerializer.new(@crop)
    end
  end

  def create
    if missing_params?
      render json: { errors: 'Name, days to maturity, and date planted cannot be blank' }, status: :bad_request
    else
      crop = Crop.create(crop_params)
      render json: CropSerializer.new(crop), status: :created
    end
  end

  private

  def crop_params
    params.require(:crop).permit(:name, :variety, :days_to_maturity, :date_planted, :active)
  end

  def set_crop
    @crop = Crop.find(params[:id])
  end

  def set_location
    @location = Location.find_by(id: params[:location_id])
    render_not_found("Cannot find location with ID #{params[:location_id]}") unless @location
  end

  def missing_params?
    return true unless params[:name] &&
                       params[:days_to_maturity] &&
                       params[:date_planted]
  end
end
