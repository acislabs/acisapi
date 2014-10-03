require 'twilio-ruby'
 
class Api::V1::VerificationCodesController < ApplicationController
  include Webhookable
 
  #after_filter :set_header
  
  skip_before_action :verify_authenticity_token

  def create
  end


  def check_verification
    verification = VerificationCode.where(code: params[:code], mobile_number: params[:mobile_number]).first

    @user = User.where(mobile_number: params[:mobile_number]).first

    unless verification.nil?
        verification.destroy # delete verification code!

        @user.update_attributes(active: true)

        render json: {success: true}
    else
        render json: {success: false, message:"Your verification code is not valid!"}
    end
  end

  def destroy

  end

end