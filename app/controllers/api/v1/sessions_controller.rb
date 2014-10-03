class Api::V1::SessionsController < Api::BaseController
  skip_before_filter :authenticate_user
end