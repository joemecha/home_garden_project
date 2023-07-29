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
      render json: { errors: "Cannot find crop with ID #{params[:id]}" }, status: :not_found
    else
      render json: CropSerializer.new(@crop)
    end
  end

  def create
    if params[:name].blank?
      render json: { errors: 'Name cannot be blank' }, status: :bad_request
    else
      crop = Crop.create(crop_params)
      render json: CropSerializer.new(crop), status: :created
    end
  end

  private

  def crop_params
    params.permit(:name, :variety, :days_to_maturity, :date_planted, :active)
  end

  def set_crop
    @crop = Crop.find(params[:id])
  end

  def set_location
    @location = Location.find(params[:location_id])
  end
end
