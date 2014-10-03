class Api::V1::ProfilesController < ApplicationController
	def create
		@profile = Profile.new(trusted_params)
    
    if @profile.save
      render json: @profile
    else
      render json: {success: false}
    end
    
	end

	def trusted_params
    params.require(:profile).permit(
      :name,
      :email,
      :company,
      :website,
      :job_title,
      :profile_type,
      :default,
      :user_id,
      :avatar
    )
  end
end