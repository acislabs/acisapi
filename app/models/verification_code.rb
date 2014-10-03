# coding: utf-8
class VerificationCode < ActiveRecord::Base

  #validates :mobile_number, format: { with: /^\d{3}-?\d{4}-?\d{4}$/ }, allow_blank: true, presence: true

  validates :mobile_number, presence: true

  # after_create :issue_verification_code
  # after_create :send_verification_code

  scope :not_active, ->{ where(active: false) }

  def self.send_verification_code(mobile_number, name)
    code = Constants::VERIFICATION_CODE_LENGTH.times.map{ Random.rand(9) + 1 }.join


    clean_number = "+" + mobile_number

    verification_code = VerificationCode.where(mobile_number: clean_number).first_or_create(
      mobile_number: clean_number,
      code: code,
      name: name
    )

    if verification_code.save
      verification_code.send_verification(code, verification_code.mobile_number, verification_code.name)
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