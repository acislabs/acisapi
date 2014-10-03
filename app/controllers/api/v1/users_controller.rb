class Api::V1::UsersController < Api::BaseController
  def index
    if current_user
      render json: Api::Response.build(true, current_user, active: current_user.active), status: 200
    else
      render json: Api::Response.build(true, nil, message: "User not found"), status: 200
    end
  end

  def create_user
    @user = User.new(trusted_params.update(device_token: params[:device_token]))
    if @user.save
      VerificationCode.send_verification_code(params[:user][:mobile_number], params[:name])
      render json: Api::Response.build(true, current_user), status: 200
    else
      render json: Api::Response.build(false, current_user, message:"Your verification code is not valid!"), status: 400
    end
  end

  def get_user
    user = current_user.unignored.find_by(params[:mobile_number])
    if user.nil?
      render json: Api::Response.build(true, current_user, user: user), status: 200
    else
      render json: Api::Response.build(false, current_user, message: "User not found"), status: 404
    end
  end

  def ignore
    user = current_user.unignored.find_by(params[:mobile_number])

    if user.present?
      current_user.ignored_users << user
    end

    render json: Api::Response.build(true, current_user), status: 200
  end

  def deactivate_user
   if(current_user.active == true)
    current_user.update_attributes(active: false)
    render json: Api::Response.build(true, message:"Deactivated Account"), status: 200
   else
    render json: Api::Response.build(false, message: "User failed to deactivate"), status: 400
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