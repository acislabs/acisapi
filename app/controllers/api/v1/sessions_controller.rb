class Api::V1::SessionsController < ApplicationController

	def create
		auth_token = User.find_by(mobile_number: params[:mobile_number], device_token: params[:device_token])
		unless auth_token.nil?
			if auth_token == params[:device_token]
				render json: {success: true}
	    end
	  else
	  	render json: {success: false}
	   end
	end
end