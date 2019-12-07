class SharedLinksController < ApplicationController
  before_action :redirect_to_root_unless_signed_in, :shared_link_params, :term

  def show
    user = SharedLink.available.find_by(token: shared_link_params[:token])&.user || current_user
    @owner_name = user.name
    @activities = user.activities.on(@term)
    @term_string = shared_link_params[:on]
    render "activities/on_term/index"
  end

  def create
    shared_link = current_user.shared_links.build(on: @term)
    if shared_link.save
      flash[:success] = "共有リンクを作成しました"
    else
      flash[:error] = "共有リンクの作成に失敗しました"
    end

    redirect_to root_path
  end

  def destroy
    return redirect_to root_path unless current_user.has_available_link_on?(@term)

    if current_user.shared_links.available.on(@term).map(&:destroy)
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

    def term
      @term ||= shared_link_params[:on]
    end
end
