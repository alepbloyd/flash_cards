require './lib/turn'
require './lib/card'
require './lib/deck'

class Round

  attr_reader :deck, :turns, :turn_count,:used_card_array,:number_correct

  def initialize(deck)
    @deck = deck
    @turns = []
    @turn_count = 0
    @number_correct = 0
    @used_card_array = []
  end

  def current_card
    @deck.cards.first
  end

  def take_turn(guess)
    new_turn = Turn.new(guess,@deck.cards.first)
    @used_card_array << @deck.cards.first
    @deck.cards.rotate!(1)
    if new_turn.guess == new_turn.card.answer
      increment_number_correct
    end
    @turns << new_turn
    increment_turn_count
    new_turn
  end

  def correct?
    take_turn.guess == take_turn.answer
  end

  def increment_number_correct
    @number_correct += 1
  end

  def increment_turn_count
    @turn_count += 1
  end

  def number_correct_by_category(category)
    correct_count_aggregator = 0
    @turns.each do |turn|
      if turn.card.category == category && turn.guess == turn.card.answer
        correct_count_aggregator += 1
      end
    end
    correct_count_aggregator
  end

  def percent_correct
    (@number_correct.to_f/@turn_count.to_f)*100
  end

  def percent_correct_by_category(category)
    turn_count_by_category = 0
    correct_count_aggregator = 0

    @turns.each do |turn|
      if turn.card.category == category
        turn_count_by_category += 1
      end
    end

    @turns.each do |turn|
      if turn.card.category == category && turn.guess == turn.card.answer
        correct_count_aggregator += 1
      end
    end

    (correct_count_aggregator.to_f/turn_count_by_category.to_f)*100
  end

end
