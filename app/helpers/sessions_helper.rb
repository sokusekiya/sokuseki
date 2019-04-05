module SessionsHelper
  def signed_in?
    !!self.current_user
  end

  def current_user
    # FIXME: JWTを受け取り方
    # Bearer tokenにしたいけど、フロント側をまだ作ってないのでQuery String経由にして試す
    token = params[:token]
    return if token.nil?

    payload = JsonWebToken.decode(token)
    User.find_by(id: payload[:user_id])
  end
end
