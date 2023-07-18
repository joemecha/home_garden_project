class GardensController < ApplicationController
  def index
    if Garden.all.none?
      render json: { message: 'You currently have no gardens.'}
    else
      render json: GardenSerializer.new()
    end
  end

  def show
  end
end
