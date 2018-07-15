class ApplicationController < ActionController::Base
  include SessionsHelper

  def redirect_to_root_unless_signed_in
    unless signed_in?
      flash[:notice] = "サインインしてください"

      redirect_to root_path
    end
  end
end
