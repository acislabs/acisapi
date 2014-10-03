# coding: utf-8
class User < ActiveRecord::Base
  has_many :profiles
  # has_many :ignored_users

  validates_presence_of :mobile_number, :device_token

  def self.create_default_profile(name)
		Profile.create(
			name: name
    )
	end
end