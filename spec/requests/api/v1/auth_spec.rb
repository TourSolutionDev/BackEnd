# spec/requests/api/v1/auth_spec.rb

require 'rails_helper'
RSpec.describe 'API::V1::Auth', type: :request do
  let (:user) { create(:user) }

  describe 'POST /api/v1/auth/sign_in' do
    it 'should return authentication headers on successful sign in' do
      post '/api/v1/auth/sign_in', params: { email: user.email, password: user.password }
      expect(response).to have_http_status(:success)
      expect(response.headers.keys).to include('client', 'access-token', 'uid')
    end

    it 'should return unauthorized status with invalid credentials' do
      post '/api/v1/auth/sign_in', params: { email: 'invalid@example.com', password: 'invalidpassword' }

      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns unauthorized status with empty request' do
      post '/api/v1/auth/sign_in', params: {}
      expect(response).to have_http_status(:unauthorized)
    end

  end

  describe 'POST /api/v1/auth/sign_out' do
    it 'should sign out the user' do
      # Sign in the user and get authentication headers
      post '/api/v1/auth/sign_in', params: { email: user.email, password: user.password }
      auth_headers = {
        'uid' => response.headers['uid'],
        'client' => response.headers['client'],
        'access-token' => response.headers['access-token']
      }

      # Now use the authentication headers to sign out the user
      delete '/api/v1/auth/sign_out', headers: auth_headers

      expect(response).to have_http_status(:success)
    end

    it 'returns unauthorized status without authentication headers' do
      delete '/api/v1/auth/sign_out', headers: {}
      expect(response).to have_http_status(:not_found)
      expect(response.body).to include('User was not found or was not logged in.')

    end

  end

  #test for user registration
  describe 'POST /api/v1/auth' do
    it 'registers a new user' do
      user_attributes = attributes_for(:user) # Using FactoryBot's attributes_for method
      post '/api/v1/auth', params: user_attributes
      expect(response).to have_http_status(:success)
      expect(response.headers.keys).to include('client', 'access-token', 'uid')
    end

    it 'returns unprocessable_entity status with invalid user attributes' do
      post '/api/v1/auth', params: { user: { email: '', password: 'password' } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
end


  # Add more test cases for other authentication endpoints as needed
end
