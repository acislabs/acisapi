class Api::V1::UsersController < Api::BaseController
  skip_before_filter :authenticate_user, only: :create_user

  def index
    if current_user
      render json: Api::Response.build(true, current_user, active: current_user.active), status: 200
    else
      render json: Api::Response.build(true, nil, message: "User not found"), status: 200
    end
  end

  def create_user
    User.where(device_token: params[:device_token]).update_all(device_token: nil)
    user = User.find_or_initialize_by(mobile_number: MobileParser.number_for_saving(trusted_params[:mobile_number]))
    user.assign_attributes(device_token: params[:device_token])
    if user.save
      VerificationCode.send_verification_code(params[:user][:mobile_number], params[:name], nil)
      render json: Api::Response.build(true, user), status: 200
    else
      render json: Api::Response.build(false, user, errors: user.errors), status: 400
    end
  end

  def get_user
    user = User.find_by(mobile_number: MobileParser.number_for_saving(params[:mobile_number]))
    ignored_user = current_user.ignored_users.find_by(ignorable_id: user.id) if user.nil?

    if user.present? and ignored_user.blank?
      render json: Api::Response.build(true, current_user, user.as_json), status: 200
    else
      render json: Api::Response.build(false, current_user, message: "User not found"), status: 404
    end
  end

  def ignore
    user = User.find_by(mobile_number: MobileParser.number_for_saving(params[:mobile_number]))
    ignored_user = current_user.ignored_users.find_by(ignorable_id: user.id)

    if user.present? and ignored_user.blank?
      current_user.create(ignorable_id: user.id)
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