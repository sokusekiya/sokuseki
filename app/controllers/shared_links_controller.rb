class SharedLinksController < ApplicationController
  before_action :redirect_to_root_unless_signed_in, :shared_link_params

  def create
    SharedLink.create(user: current_user, expired_at: Time.zone.tomorrow, on: params[:on], token: 'hogehoge')
    redirect_to root_path
  end

  def destroy
  end

  private
  def shared_link_params
    params.permit(:on)
  end
end
