class Api::V1::UsersController < ApplicationController
	def create
    verification = VerificationCode.find_by(code: params[:code], mobile_number: params[:mobile_number])
    unless verification.nil?
      @user = User.new(trusted_params)
      if @user.save
        render json: {user: @user, success: true}
      else
        render json: {success: false}
      end
    else
      return false
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
      :access_token,
      :operating_system,
      :device_token,
      :active
    )
  end
end