class Api::V1::UsersController < ApplicationController
	skip_before_action :verify_authenticity_token

  def create_user
    @user = User.new(trusted_params)
    if @user.save
      binding.pry
      VerificationCode.send_verification_code(params[:user][:mobile_number], params[:name])
      render json: {success: true}
    else
      render json: {success: false, message:"Your verification code is not valid!"}
    end
  end

  def update
  end

  def index
    @users = User.all
    render json: @users
  end

  def get_user
    @user = User.find_by(params[:mobile_number])
    unless @user.nil?
      render json: {user: @user, success: true}
    end
  end

	def trusted_params
    params.require(:user).permit(
      :mobile_number,
      :operating_system,
      :device_token
    )
  end
end