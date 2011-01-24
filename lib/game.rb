class Game
  attr_accessor :chips

  FIRST_CHAR = lambda {|input| input[0].chr.downcase}

  def initialize
    @chips = 500
    @deck = Deck.new
  end

  def play_round
    system "clear"
    puts "You have #{@chips} chips"
    max_bet = [@chips, 100].min
    bet = get_valid_input "Enter an integer bid between 1 and #{max_bet}",
                          (1..max_bet),
                          lambda(&:to_i)
    @dealer = Hand.new @deck
    puts "Dealer: #{Deck.card_string @dealer.cards[0]}"

    hands = [Hand.new @deck]
    hand_index = 0
    until hands.last.stood? || @dealer.blackjack?
      if hands[hand_index].blackjack?
        hands[hand_index].stand
        puts "Blackjack!"
      end
      if hands[hand_index].stood?
        hand_index += 1
        next
      end
      puts "Your hand: #{hands[hand_index]}"
      possibilities = [['[h]it', 'h'], ['[s]tand', 's']]
      if hands[hand_index].cards.length == 2 && @chips >= (bet * (hands.length + 1))
        possibilities << ['[d]ouble-down', 'd']
        possibilities << ['s[p]lit', 'p'] if hands[hand_index].cards[0] == hands[hand_index].cards[1]
      end
      choice = get_valid_input possibilities.map{|p| p[0]}.join(' or ') + '?',
                               possibilities.map {|p| p[1]},
                               FIRST_CHAR
      case choice
      when 's'
        hands[hand_index].stand
      when 'h'
        hands[hand_index].hit @deck
      when 'd'
        hands[hand_index].double_down @deck
      when 'p'
        card = hands[hand_index].cards.first
        hands.delete_at hand_index
        2.times do
          hands << Hand.new(@deck, card)
        end
      end
    end
    puts "Your final hand[s]:\n#{hands.join "\n"}"

    # hit even if the player got blackjack because
    # and theoretically there are other people at the table
    until @dealer.final_sum >= 17
      @dealer.hit @deck
    end
    @dealer.stand

    puts "Dealer's hand:\n#{@dealer}"
    # since bets when you split/double-down are the same,
    # we can just sum the outcomes and multiply that by the bet
    # to get the net change in money
    results = hands.map {|hand| hand.result(@dealer)}
    @chips += (results.reduce(:+) * bet).to_i
    @chips = @chips.to_i
    puts "You have #{@chips} chips"
    if @chips <= 0
      puts "Thanks for playing!"
      return false
    end
    continue = get_valid_input "Play again? (y/n)",
                               ['y', 'n'],
                               FIRST_CHAR
    continue == 'y'
  end

  def get_valid_input(prompt, valid_inputs, before_block=lambda{|foo| foo})
    while true
      puts prompt
      input = before_block[gets.chomp]
      return input if valid_inputs.include? input
      puts "Invalid! Try again."
    end
  end
end
