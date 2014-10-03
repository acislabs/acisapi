# coding: utf-8
class Profile < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true

  # Paperclip
  has_attached_file :photo, 
    styles: {
    	thumb: "150x150>"
		},
		default_url: lambda { |image| ActionController::Base.helpers.asset_path('default.png') },
		preserve_files: true


	def create_default_profile(name)
		Profile.create(
			name: params[:name]
    )
	end

end