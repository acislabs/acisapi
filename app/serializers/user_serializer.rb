class UserSerializer < ActiveModel::Serializer
  attributes :id, :mobile_number, :access_token, :operating_system, :device_token, :active, :profiles

  def profiles
    object.profiles
  end
  
end
