class SharedLinksController < ApplicationController
  before_action :redirect_to_root_unless_signed_in, :shared_link_params

  def create
  end

  def destroy
  end

  private
  def shared_link_params
    params.permit(:month, :term)
  end
end
