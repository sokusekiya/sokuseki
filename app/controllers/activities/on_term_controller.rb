class Activities::OnTermController < ApplicationController
  before_action :redirect_to_root_unless_signed_in, :on_term_params

  def index
    user = SharedLink.available.find_by(token: on_term_params[:token])&.user || current_user
    @term_string = params[:term_string]
    @activities = user.activities.on(@term_string)
  end

  private

    def on_term_params
      params.permit(:term_string, :token)
    end
end
