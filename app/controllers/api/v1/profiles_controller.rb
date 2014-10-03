class Api::V1::ProfilesController < Api::BaseController
  def create_profile
		profile = current_user.new(trusted_params)
    
    if profile.save
      render json: Api::Response.build(true, current_user, profile: profile.as_json), status: 200
    else
      render json: Api::Response.build(false, current_user), status: 400
    end
	end

  def index
    render json: Api::Response.build(true, current_user, profile: current_user.default_profile.as_json), status: 200
  end

	def trusted_params
    params.require(:profile).permit(
      :name,
      :email,
      :company,
      :website,
      :job_title,
      :user_id,
      :avatar
    )
  end
end