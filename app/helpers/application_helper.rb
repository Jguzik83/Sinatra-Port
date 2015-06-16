module ApplicationHelper
  def logged_in?
    !!session[:user_id]
    # redirect('/') unless is_authenticated?
  end

  # def is_authenticated?
  #   return !!session[:id]
  # end

  def current_user
    if session[:user_id]
      return User.find(session[:id])
    else
      return nil
    end
  end

  def cur_card
    session[:guesses]
  end

end
