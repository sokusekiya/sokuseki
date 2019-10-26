class SharedLinksController < ApplicationController
  before_action :redirect_to_root_unless_signed_in, :shared_link_params

  def create
    shared_link = SharedLink.new(user: current_user, expired_at: Time.zone.tomorrow, on: params[:on], token: 'hogehoge')
    if shared_link.save
      flash[:success] = "招待リンクを作成しました"
      redirect_to root_path
    else
      flash[:error] = "エラーが発生しました"
      redirect_to root_path
    end
  end

  def destroy
  end

  private
  def shared_link_params
    params.permit(:on)
  end
end
