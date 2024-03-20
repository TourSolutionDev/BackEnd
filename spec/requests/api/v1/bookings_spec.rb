require 'rails_helper'



RSpec.describe "/api/v1/bookings", type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Api::V1::Booking. As you add validations to Api::V1::Booking, be sure to
  # adjust the attributes here as well.
  let(:user) { create(:user) }
  let(:tour) { create(:api_v1_tour) }
  let(:valid_attributes) {
    {
      user_id: user.id,
      tour_id: tour.id,
      booking_status: "pending",
      profile_attributes: { first_name: "John", last_name: "Doe", phone_number: "1234567890", passport: "1234567890" }
    }
  }

  let(:invalid_attributes) {
    {
      user_id: nil,
      tour_id: nil,
      booking_status: nil
    }
  }

  let(:user_headers) { user.create_new_auth_token }
  let(:valid_headers) {
    {
      'Content-Type': 'application/json',
      'access-token': user_headers['access-token'],
      'uid': user_headers['uid'],
      'client': user_headers['client']
  }
}

  describe "GET /index" do
    it "renders a successful response" do
      get api_v1_bookings_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      booking = create(:api_v1_booking, user: user, tour: tour)
      get api_v1_booking_url(booking), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Api::V1::Booking" do
        expect {
          post api_v1_bookings_url,
               params: { api_v1_booking: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Api::V1::Booking, :count).by(1)
      end

      it "renders a JSON response with the new api_v1_booking" do
        post api_v1_bookings_url,
             params: { api_v1_booking: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Api::V1::Booking" do
        expect {
          post api_v1_bookings_url,
               params: { api_v1_booking: invalid_attributes }, as: :json
        }.to change(Api::V1::Booking, :count).by(0)
      end

      it "renders a JSON response with errors for the new api_v1_booking" do
        post api_v1_bookings_url,
             params: { api_v1_booking: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          booking_status: "confirmed"
    }
      }

      it "updates the requested api_v1_booking" do
        booking = create(:api_v1_booking, user: user, tour: tour)
        patch api_v1_booking_url(booking),
              params: { api_v1_booking: new_attributes }, headers: valid_headers, as: :json
        booking.reload
        expect(booking.booking_status).to eq("confirmed")
      end

      it "renders a JSON response with the api_v1_booking" do
        booking = create(:api_v1_booking, user: user, tour: tour)
        patch api_v1_booking_url(booking),
              params: { api_v1_booking: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the api_v1_booking" do
        booking = create(:api_v1_booking, user: user, tour: tour)
        patch api_v1_booking_url(booking),
              params: { api_v1_booking: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested api_v1_booking" do
      booking = create(:api_v1_booking, user: user, tour: tour)
      expect {
        delete api_v1_booking_url(booking), headers: valid_headers, as: :json
      }.to change(Api::V1::Booking, :count).by(-1)
    end
  end
end
