class SharedLinksController < ApplicationController
  before_action :redirect_to_root_unless_signed_in, :shared_link_params

  def create
    return redirect_to root_path unless current_user.shared_links.available.where(on: shared_link_params[:on]).empty?

    token = SecureRandom.hex(32)
    shared_link = SharedLink.new(user: current_user, expired_at: 1.minute.after, on: shared_link_params[:on], token: token)
    if shared_link.save
      flash[:success] = "招待リンクを作成しました"
    else
      flash[:error] = "エラーが発生しました"
    end

    redirect_to root_path
  end

  def destroy
    return redirect_to root_path if current_user.shared_links.available.where(on: shared_link_params[:on]).empty?

    if current_user.shared_links.available.on(shared_link_params[:on]).first.destroy
      flash[:success] = "招待リンクを作成しました"
    else
      flash[:error] = "エラーが発生しました"
    end

    redirect_to root_path
  end

  private

    def shared_link_params
      params.permit(:on)
    end
end
