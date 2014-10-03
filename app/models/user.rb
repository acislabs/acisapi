# coding: utf-8
# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  mobile_number    :string(255)
#  access_token     :string(255)
#  operating_system :string(255)      default("Android"), not null
#  device_token     :string(255)
#  active           :boolean          default(FALSE), not null
#  created_at       :datetime
#  updated_at       :datetime
#

class User < ActiveRecord::Base
  include Concerns::AsJson

  has_many :profiles
  has_many :ignored_users

  scope :active, -> {where active: true}
  
  validates_presence_of :mobile_number, :device_token
  before_create :generate_access_token
  before_create :sanitize_mobile_number

  def create_default_profile(name)
		profiles.create(name: name, default: true)
  end

  def default_profile
    profiles.find_by(default: true)
  end

  def active!
    update(active: true)
  end

  def name
    default_profile.present? ? default_profile.name : VerificationCode.find_by(mobile_number: mobile_number).try(:name)
  end

  def first_name
    name.to_s.split(' ').first
  end

  # def avatar; default_profile.try :avatar; end

  def email; default_profile.try :email; end

  def company; default_profile.try :company; end
  def website; default_profile.try :website; end
  def job_title; default_profile.try :job_title; end

  private

  def only_attributes
    %w(mobile_number active)
  end

  def methods_list
    %w(name first_name email company website job_title)
  end

  def generate_access_token
    loop do
      @token = Devise.friendly_token
      break unless User.exists?(access_token: @token)
    end

    assign_attributes(access_token: @token)
  end


  def sanitize_mobile_number
    assign_attributes(mobile_number: MobileParser.number_for_saving(mobile_number))
  end
end