require 'twilio-ruby'
 
class Api::V1::VerificationCodesController < ApplicationController
  include Webhookable
 
  #after_filter :set_header
  
  skip_before_action :verify_authenticity_token

  def create

    code = Constants::VERIFICATION_CODE_LENGTH.times.map{ Random.rand(9) + 1 }.join

    @verification_code = VerificationCode.new(
      mobile_number: User.first.mobile_number,
      code: code,
      name: User.first.profiles.first.name
    )

    if @verification_code.save
      send_verification(code, @verification_code.mobile_number, @verification_code.name)
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

    puts sms.from
  end

  # def trusted_params
  #   params.require(:verification_code).permit(
  #     :mobile_number,
  #     :code,
  #     :name
  #   )
  # end
end