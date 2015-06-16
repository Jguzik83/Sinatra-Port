require 'pry'
class DecksController < ApplicationController
  def show
    @deck = Deck.find(params[:id])
    @round = Round.create(user_id: session[:user_id], deck_id: @deck.id)
    session[:guesses] = 0
  end

  def start_round
    if logged_in?
      @deck = Deck.find_by(id: params[:deck_id])
      @round = Round.find_by(id: params[:round_id])
      @guess = Guess.new
    else
      @errors = "Sorry, you must be logged in to play this deck"
      render text: 'sorry'
    end
  end

  def submit_answer
    ## we need :deck_id, :id, :answer
    ## cur_card = helper method
    p params
    @answer = params[:answer]
    @deck = Deck.find_by(id: params[:deck_id])
    @round = Round.find_by(id: params[:id])
    @guess = Guess.create(round_id: @round.id, card_id: @deck.cards[cur_card].id)
      if params[:answer].downcase == @deck.cards[cur_card].answer.downcase
        @guess.update_attributes(correct: true)
      else
        @guess.update_attributes(correct: false)
      end
    session[:guesses] += 1
    if session[:guesses] == @deck.cards.size
      redirect_to "decks/#{@deck.id}/round/#{@round.id}/results"
    else
      redirect_to "decks/#{@deck.id}/round/#{@round.id}"
    end
  end

  def results
    if is_authenticated?
      @deck = Deck.find_by(id: params[:deck_id])
      @round = Round.find_by(id: params[:id])
      @correct = Guess.where(round: @round, correct: true)
      @incorrect = Guess.where(round: @round, correct: false)
      erb :'results/show'
    else
      @errors = "Sorry, you must be logged in to view results."
      render text: ''
    end
  end
end
