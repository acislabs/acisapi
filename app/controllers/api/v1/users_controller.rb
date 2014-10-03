class Api::V1::UsersController < ApplicationController
	def create
		@user = User.new(trusted_params)
    
    if @user.save
      render json: @user
    else
      render json: {success: false}
    end
    
	end

	def verification
    
    if @user.verify_and_save(trusted_params)
      
    else
      
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