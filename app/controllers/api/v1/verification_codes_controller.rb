require 'twilio-ruby'
 
class Api::V1::VerificationCodesController < Api::BaseController
  include Webhookable
 
  def check_verification
    verification = VerificationCode.verify(params[:code], params[:mobile_number])

    @user = User.where(mobile_number: params[:mobile_number]).first

    unless verification.nil?
        @user.create_default_profile(verification.name)
        verification.destroy # delete verification code!
        @user.active!

        render json: Api::Response.build(true, current_user), status: 200
    else
        render json: Api::Response.build(false, current_user, message: "Your verification code is not valid!"), status: 400
    end
  end
end