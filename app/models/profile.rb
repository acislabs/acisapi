# coding: utf-8
# == Schema Information
#
# Table name: profiles
#
#  id                  :integer          not null, primary key
#  profile_type        :string(255)      default("Personal"), not null
#  name                :string(255)
#  email               :string(255)
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  website             :string(255)
#  company             :string(255)
#  job_title           :string(255)
#  default             :boolean          default(FALSE), not null
#  user_id             :integer
#  created_at          :datetime
#  updated_at          :datetime
#

class Profile < ActiveRecord::Base
  include Concerns::AsJson

  belongs_to :user

  validates :name, presence: true

  # Paperclip
  has_attached_file :photo, 
    styles: {
    	thumb: "150x150>"
		},
		default_url: lambda { |image| ActionController::Base.helpers.asset_path('default.png') },
		preserve_files: true

  delegate :mobile_number, to: :user
  
  def avatar_url
    avatar.try :url
  end

  private

  def only_attributes
    %w(name email website company job_title)
  end

  def methods_list
    %w(avatar_url mobile_number)
  end
end
