class SharedLinksController < ApplicationController
  before_action :redirect_to_root_unless_signed_in, :shared_link_params

  def show
    shared_link = SharedLink.available.find_by(token: shared_link_params[:token])
    return redirect_to root_path unless shared_link
    user = shared_link.user
    @owner_name = user.name
    @term_string = shared_link.on
    @activities = user.activities.on(@term_string)
    render "activities/on_term/index"
  end

  def create
    shared_link = current_user.shared_links.build(on: shared_link_params[:on])
    if shared_link.save
      flash[:success] = "共有リンクを作成しました"
    else
      flash[:error] = "共有リンクの作成に失敗しました"
    end

    redirect_to root_path
  end

  def destroy
    available_link = current_user.shared_links.available.find_by(token: shared_link_params[:token])
    return redirect_to root_path unless available_link

    if available_link.destroy
      flash[:success] = "共有リンクを削除しました"
    else
      flash[:error] = "共有リンクの削除に失敗しました"
    end

    redirect_to root_path
  end

  private

    def shared_link_params
      params.permit(:on, :token)
    end
end
