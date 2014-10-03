# coding: utf-8
# == Schema Information
#
# Table name: verification_codes
#
#  id            :integer          not null, primary key
#  mobile_number :string(255)
#  code          :string(255)
#  name          :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class VerificationCode < ActiveRecord::Base
  #validates :mobile_number, format: { with: /^\d{3}-?\d{4}-?\d{4}$/ }, allow_blank: true, presence: true

  validates :mobile_number, presence: true

  # after_create :issue_verification_code
  # after_create :send_verification_code

  scope :not_active, ->{ where(active: false) }

  def self.send_verification_code(mobile_number, name)
    code = Constants::VERIFICATION_CODE_LENGTH.times.map{ Random.rand(9) + 1 }.join
    
    verification_code = VerificationCode.find_or_initialize_by(mobile_number: MobileParser.number_for_saving(mobile_number))

    if verification_code.new_record?
      verification_code.update(
        mobile_number: MobileParser.number_for_saving(mobile_number),
        code: code,
        name: name
      )
      verification_code.send_verification
    end
  end

  def send_verification

    # SEND SMS!!!

    account_sid = CONFIG[:twilio_sID]
    auth_token = CONFIG[:twilio_auth_token]
    my_number = CONFIG[:twilio_number]

    @client = Twilio::REST::Client.new account_sid, auth_token
     
    sms = @client.account.sms.messages.create(:body => "Hi #{name}. Your verification code is #{code}",
        :to => MobileParser.number_for_sending(mobile_number),
        :from => my_number)
  end

  def self.verify(code, mobile_number)
    self.find_by(code: code, mobile_number: MobileParser.number_for_saving(mobile_number))
  end
end
