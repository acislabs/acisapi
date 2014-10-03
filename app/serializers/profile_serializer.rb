class ProfileSerializer < ActiveModel::Serializer

  attributes :id, :name, :email, :website, :company, :job_title, :profile_type, :default, :user_id, :avatar

  def primary_photo
    object.first.avatar
  end

end
