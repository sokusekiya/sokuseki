module SessionsHelper
  def sign_in(user)
    session[:user_id] = user.id
    @current_user = user
  end

  def sign_out
    @current_user = nil
    session.delete(:user_id)
  end

  def signed_in?
    !!self.current_user
  end

  def current_user
    return if session[:user_id].nil?

    @current_user ||= User.find_by(id: session[:user_id])
  end
end
