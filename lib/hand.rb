class Hand
  attr_accessor :cards, :stood

  def initialize(deck, first=nil)
    @cards = []
    @cards << (first ? first : deck.draw)
    @cards << deck.draw
    # automatically stand if it's a blackjack
    @stood = false
    @multiplier = 1
  end

  def hit(deck)
    @cards << deck.draw
    stand if final_sum > 21
  end

  def score_string
    return final_sum if stood
    under_21 = possible_under_21
    return under_21.join('/') unless under_21.empty?
    final_sum
  end

  # returns the most favorable sum possible
  # (ie. tries to count aces such that they get as high
  #  of a score as possible that's <21)
  def final_sum
    min_sum, aces = sum_and_aces
    # don't go any higher if their min is already busting
    return min_sum if min_sum > 21
    possible_under_21[-1]
  end

  def possible_under_21
    min_sum, aces = sum_and_aces
    possibile = (0..aces).to_a.map {|num_aces| min_sum + 10 * num_aces}.reject{|score| score > 21}
  end

  # returns sum counting aces as 1
  # and number of aces
  def sum_and_aces
    @cards.reduce [0,0] do |sums, card|
      [sums[0] + [card, 10].min, sums[1] + (card == 1 ? 1: 0)]
    end
  end

  def to_s
    @cards.map{|c| Deck.card_string c}.join(', ') + " (#{score_string})"
  end

  def stood?
    stood
  end

  def stand
    @stood = true
  end

  def double_down(deck)
    hit deck
    stand
    @multiplier *= 2
  end

  def result(dealer)
    # blackjacks
    # push if they're both blackjack
    # player gets a 3:2 payout if they get blackjack and dealer doesn't
    # player loses on dealer blackjack, even if they get 21 too
    return 0 if blackjack? && dealer.blackjack?
    return @multiplier * 1.5 if blackjack?
    return -@multiplier if dealer.blackjack?

    return -@multiplier if final_sum > 21
    return @multiplier if dealer.final_sum > 21

    @multiplier * (final_sum <=> dealer.final_sum)
  end

  def blackjack?
    @cards.length == 2 && final_sum == 21
  end
end
