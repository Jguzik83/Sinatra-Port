class PagesController < ApplicationController
  def home
    if !logged_in?
      @user = User.new
    else
      @user = User.find(session[:user_id])
      @decks = Deck.all
    end
  end

  private

  def logged_in?
    !!  session[:user_id]
  end


end
