class Api::Response
  attr_accessor :success, :response, :resource
	def initialize(success, resource, response)
    @success = success
    @resource = resource
    @response = response
  end

  def add_response hash
    hash.update response
  end

  def add_credentials hash
    hash.update(uid: resource.id, access_token: resource.access_token) if resource.present?
  end

  def merged_response
    response = {success: success}
    add_response response
    add_credentials response
    response
  end

  class << self
    def build(success, resource = nil, **response)
      new(success, resource, response).merged_response.as_json
    end
  end
end