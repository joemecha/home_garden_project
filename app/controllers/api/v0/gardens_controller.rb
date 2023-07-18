class GardensController < ApplicationController
  before_action :set_garden, only: :show
  def index
    if Garden.all.none?
      render json: { message: 'You currently have no gardens.'}
    else
      render json: GardenSerializer.new(Garden.all)
    end
  end

  def show
    if @garden.nil?
      render json: { errors: "No garden with ID #{params[:id]}" }, status: :not_found
    else
      render json: GardenSerializer.new(@garden)
    end
  end

  private

  def set_garden
    @garden = Garden.find(params[:id])
  end
end
