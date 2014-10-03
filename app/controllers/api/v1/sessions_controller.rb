class Api::V1::SessionsController < Api::BaseController
  skip_before_filter :authenticate_user

  def create
  	user = User.find_by(device_token: params[:device_token])

  	if user
  	  hash = user.as_json
  	  # render json: Api::Response.build(true, user, mobile_number: user.mobile_number, name: user.name, status: user.status), status: 200
  	  render json: Api::Response.build(true, user, user.as_json), status: 200
    else
      render json: Api::Response.build(true, nil, message: "User not found"), status: 200
    end
end
end