class Api::V1::ProfilesController < ApplicationController

	def create
		@profile = Profile.new(trusted_params)
    
    if @profile.save
      render json: {success: true}
    else
      render json: {success: false}
    end
	end

  def destroy
  end

  def update
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