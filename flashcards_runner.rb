require './lib/card'
require './lib/turn'
require './lib/deck'
require './lib/round'
require './lib/card_generator'

# @card_1 = Card.new("Which NFL position has, on average, the shortest career?", "running back", :Sports)
# @card_2 = Card.new("Where were the Utah Jazz originally located?", "new orleans", :Sports)
# @card_3 = Card.new("What year was the World Wide Web launched in?", "1991", :STEM)
# @card_4 = Card.new("What animal has the highest blood pressure?", "giraffe", :STEM)
# @card_5 = Card.new("Which Queen of England and wife of Henry VIII had six fingers on one of her hands?", "anne boleyn", :History)
# @card_6 = Card.new("What was the former name of Times Square before it was renamed in 1904?", "longacre square", :History)
# @deck = Deck.new([@card_1, @card_2, @card_3, @card_4, @card_5, @card_6])
@cards = CardGenerator.new("cards.txt").cards
@deck = Deck.new(@cards)
@round = Round.new(@deck)

def start
  puts "Welcome! You're playing with #{@cards.count} cards."
  40.times {print "-"}
  puts "\n"
  play
end

def play
  guesses = @deck.cards.count
  current_turn = 1
  while current_turn <= guesses
    puts "This is card number #{current_turn} out of #{guesses}."
    print "Question: #{@round.current_card.question} "
    guess = gets.chomp.to_s.downcase
    new_turn = @round.take_turn(guess)
    puts @round.turns.last.feedback
    current_turn += 1
  end
  finish_game
end

def finish_game
  puts "***** Game over! *****"
  puts "You had #{@round.number_correct} correct guesses out of #{@round.turns.count} for a total score of #{@round.percent_correct}%"
  categories = @round.turns.map do |turn|
    turn.card.category
  end
  categories = categories.uniq
  categories.each do |category|
    puts "#{category} - #{@round.percent_correct_by_category(category)}% correct"
  end
end

start
