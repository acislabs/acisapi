class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  # before_filter :headers

  # def headers
  # 	response.headers['ACCEPT'] = 'application/vnd.acis+json'
  # end
end
