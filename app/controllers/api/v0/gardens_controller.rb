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
    if params[:name].blank?
      render json: { errors: 'Name cannot be blank' }, status: :bad_request
    else
      garden = Garden.create(garden_params)
      render json: GardenSerializer.new(garden), status: :created
    end
  end

  private

  def garden_params
    params.require(:garden).permit(:name, :size)
  end

  def set_garden
    @garden = Garden.find_by(id: params[:id])
  end
end
