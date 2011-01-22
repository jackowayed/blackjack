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

  def sum
    @cards.reduce :+
  end
end
