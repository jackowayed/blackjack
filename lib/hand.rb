class Hand
  attr_accessor :cards

  def initialize(deck, first=nil)
    @cards = []
    @cards << (first ? first : deck.draw)
    @cards << deck.draw
  end

  def hit(deck)
    @cards << deck.draw
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
end
