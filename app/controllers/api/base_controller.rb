class Api::BaseController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :verify_device_token
	before_filter :authenticate_user
	helper_method :current_user

	def current_user
    @current_user
	end

	private

  def verify_device_token
    unless params[:device_token].present?
      render json: {success: false, message: "Missing device_token parameter"}
    end
  end

	def authenticate_user
    return unless params[:access_token].present?

    user = User.find_by(device_token: params[:device_token])

    if user.present? and Devise.secure_compare(user.access_token, params[:access_token])
      @current_user ||= user
    else
      render json: {success: false, message: "Invalid user"}, status: 400
    end
	end
end