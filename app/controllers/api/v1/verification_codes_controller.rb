require 'twilio-ruby'
 
class Api::V1::VerificationCodesController < ApplicationController
  include Webhookable
 
  #after_filter :set_header
  
  skip_before_action :verify_authenticity_token

  def create
   
    code = Constants::VERIFICATION_CODE_LENGTH.times.map{ Random.rand(9) + 1 }.join

    clean_number = params[:mobile_number].gsub(" ", "+")

    @verification_code = VerificationCode.where(mobile_number: clean_number).first_or_create(
      mobile_number: clean_number,
      code: code,
      name: params[:name]
    )

    if @verification_code.save
      send_verification(code, @verification_code.mobile_number, @verification_code.name)
      render json: {success: true}
    else
      render json: {success: false}
    end
  end
 
  def send_verification(verification_code, mobile_number, name)

    # SEND SMS!!!

    account_sid = CONFIG[:twilio_sID]
    auth_token = CONFIG[:twilio_auth_token]
    my_number = CONFIG[:twilio_number]

    @client = Twilio::REST::Client.new account_sid, auth_token
     
    sms = @client.account.sms.messages.create(:body => "Hi #{name}. Your verification code is #{verification_code}",
        :to => mobile_number,
        :from => my_number)
  end
end