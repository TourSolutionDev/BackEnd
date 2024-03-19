class Api::V1::BookingsController < ApplicationController
  before_action :set_api_v1_booking, only: %i[ show update destroy ]
  before_action :authenticate_api_v1_user!, only: %i[ create update destroy ]

  # GET /api/v1/bookings
  def index
    @api_v1_bookings = Api::V1::Booking.all

    render json: @api_v1_bookings
  end

  # GET /api/v1/bookings/1
  def show
    render json: @api_v1_booking
  end

  # POST /api/v1/bookings
  def create
  if api_v1_booking_params[:profile_attributes].present?
    if current_api_v1_user.profile.nil?
      current_api_v1_user.create_profile(api_v1_booking_params[:profile_attributes])
    else
      if current_api_v1_user.profile.update(api_v1_booking_params[:profile_attributes])
        render json: current_api_v1_user.profile, status: :ok
        return
      else
        render json: current_api_v1_user.profile.errors, status: :unprocessable_entity
        return
      end
    end
  elsif current_api_v1_user.profile.nil?
    render json: {error: "You need to create a profile before booking"}, status: :unprocessable_entity
    return
  end

  @api_v1_booking = current_api_v1_user.bookings.new(api_v1_booking_params.except(:profile_attributes))

  if @api_v1_booking.save
    render json: @api_v1_booking, status: :created, location: @booking
  else
    render json: @api_v1_booking.errors, status: :unprocessable_entity
  end
end


  # PATCH/PUT /api/v1/bookings/1
  def update
    if @api_v1_booking.update(api_v1_booking_params)
      render json: @api_v1_booking
    else
      render json: @api_v1_booking.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/bookings/1
  def destroy
    @api_v1_booking.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_booking
      @api_v1_booking = Api::V1::Booking.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_booking_params
      params.require(:api_v1_booking).permit(:user_id, :tour_id, :booking_status, profile_attributes: [:first_name, :last_name, :phone_number, :passport])
    end

end
