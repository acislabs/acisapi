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
  # has_many :ignored_users

  scope :active, -> {where active: true}

  validates_presence_of :mobile_number, :device_token
  before_create :generate_access_token

  def create_default_profile(name)
		profiles.create(name: name)
  end

  def default_profile
    profiles.find_by(default: true)
  end

  def active!
    update(active: true)
  end

  def generate_access_token
    loop do
      @token = Devise.friendly_token
      break unless User.exists?(access_token: @token)
    end

    assign_attributes(access_token: @token)
  end
end
