# coding: utf-8
class VerificationCode < ActiveRecord::Base

  #validates :mobile_number, format: { with: /^\d{3}-?\d{4}-?\d{4}$/ }, allow_blank: true, presence: true

  # after_create :issue_verification_code
  # after_create :send_verification_code

  scope :not_active, ->{ where(active: false) }

  def verify_and_save(attributes)
    self.assign_attributes attributes
    if self.verification_code == self.verification_code_confirmation
      self.active = true
      self.verification_code = nil
      self.save
    else
      self.errors.add(:verification_code_confirmation)
      false
    end
  end

  private

  def issue_verification_code
    self.verification_code = VERIFICATION_CODE_LENGTH.times.map{ Random.rand(9) + 1 }.join
    self.save!
  end

  def send_verification_code
    twilio_client.account.sms.messages.create(
      from: ENV["TWILIO_NUMBER"],
      to: formatted_mobile_phone_number,
      body: "#{verification_code}"
    )
  end

  def twilio_client
    @twilio_client ||= Twilio::REST::Client.new ENV["TWILIO_SID"], ENV["TWILIO_TOKEN"]
  end

  # 080-1234-5678 => # +8180-1234-5678
  def formatted_mobile_phone_number
    "+81#{self.mobile_phone_number[1..-1]}"
  end
end