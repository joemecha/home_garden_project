# frozen_string_literal: true

class Api::V0::GardensController < Api::V0::BaseController
  before_action :set_garden, only: %i[show]

  def index
    if @current_user.gardens.none?
      render json: { message: 'You currently have no gardens.'}
    else
      render json: GardenSerializer.new(Garden.all)
    end
  end

  def show
    if @garden.nil? || @garden.user_id != @current_user.id
      render_not_found("Cannot find garden with ID #{params[:id]}")
    else
      render json: GardenSerializer.new(@garden)
    end
  end

  def create
    garden = Garden.new(garden_params)

    if garden.save
      render json: GardenSerializer.new(garden), status: :created
    else
      render json: { errors: garden.errors.full_messages }, status: :bad_request
    end
  end

  private

  def garden_params
    params.require(:garden).permit(:name, :size, :user_id)
  end

  def set_garden
    @garden = Garden.find_by(id: params[:id])
  end
end
