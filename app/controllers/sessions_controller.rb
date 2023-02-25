class SessionsController < ApplicationController
  def create
    omniauth = request.env["omniauth.auth"]
    provider = omniauth.dig("provider")
    uid = omniauth.dig("uid")

    authentication = Authentication.find_by(provider:, uid:)

    if authentication
      authentication.update(
        name: omniauth.dig("info", "nickname"),
        access_token: omniauth.dig("credentials", "token"),
      )

      sign_in authentication.user
    else
      sign_in User.create_with(omniauth)
    end

    redirect_to root_path
  end

  def destroy
    sign_out

    redirect_to root_path
  end
end
