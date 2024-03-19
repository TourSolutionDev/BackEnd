class Api::V1::ToursController < ApplicationController
  before_action :set_api_v1_tour, only: %i[ show update destroy ]
  before_action :authenticate_api_v1_admin!

  # GET /api/v1/tours
  def index
    @api_v1_tours = Api::V1::Tour.all

    render json: @api_v1_tours
  end

  # GET /api/v1/tours/1
  def show
    render json: @api_v1_tour
  end

  # POST /api/v1/tours
  def create
    if params[:api_v1_tour][:category_id].present?
    # If category_id is present, it means an existing category is selected
    @api_v1_tour = Api::V1::Tour.new(api_v1_tour_params)
    else
      # If category_id is not present, it means a new category is being created
      @category = Api::V1::Category.new(category_params)
      @category.save! #

      @api_v1_tour = @category.tours.build(api_v1_tour_params)
    end

    @api_v1_tour.admin = current_api_v1_admin


    if @api_v1_tour.save
      render json: @api_v1_tour, status: :created, location: @api_v1_tour
    else
      render json: @api_v1_tour.errors, status: :unprocessable_entity
    end

  end

  # PATCH/PUT /api/v1/tours/1
  def update
    if @api_v1_tour.update(api_v1_tour_params)
      render json: @api_v1_tour
    else
      render json: @api_v1_tour.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/tours/1
  def destroy
    @api_v1_tour.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_tour
      @api_v1_tour = Api::V1::Tour.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_tour_params
      params.require(:api_v1_tour).permit(
      :name, :description, :duration, :image, :category_id,
      tour_dates_attributes: [:id, :start_date, :end_date, :_destroy],
      prices_attributes: [:id, :amount, :currency, :_destroy],
      destinations_attributes: [:id, :name, :description, :_destroy],
      activities_attributes: [:id, :name, :_destroy])
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
