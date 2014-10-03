class Api::V1::UsersController < ApplicationController
	def create
    verification = VerificationCode.find_by(code: params[:code], mobile_number: params[:mobile_number])
    unless verification.nil?
      @user = User.new(trusted_params)
      if @user.save
        render json: {user: @user, success: true}
      else
        render json: {success: false}
      end
    else
      return false
    end
	end

  def update
    @user.attributes = trusted_params
    if @campaign.save
      CampaignMailer.campaign_status_email(@campaign).deliver if params[:sendmail].eql?('yes')
      if @campaign.approved? && @campaign.start_at <= Date.today
        @campaign.live!

        # POST TO FB
        message = "Please help my campaign on Plum Alley reach its goal!"
        ticked_subscription = @campaign.user.subscription.fb_create_campaign
        post_live_campaign_facebook(@campaign, @campaign.user, message, ticked_subscription) unless @campaign.nil?
      end

      render json: @campaign, root: false
    else
      render json: {
          message: 'Validation failed', errors: @campaign.errors.full_messages
      }, status: 422
    end
  end

  def index
    @users = User.all
    render json: @users
  end

  def get_user
    @user = User.find_by(params[:mobile_number])
    unless @user.nil?
      render json: {user: @user, success: true}
    end
  end

	def trusted_params
    params.require(:user).permit(
      :mobile_number,
      :access_token,
      :operating_system,
      :device_token,
      :active
    )
  end
end