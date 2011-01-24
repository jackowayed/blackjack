class Deck
  def initialize
    reset
  end

  def draw
    # reshuffle if the shoe gets too small
    reset if @cards.length < 26

    @cards.delete_at rand(@cards.length)
  end

  def reset
    # shoe of 10 decks
    @cards = Array(1..13) * 10
  end

  def self.card_string(card)
    case card
    when 1: "A"
    when 2..10: card
    when 11: "J"
    when 12: "Q"
    when 13: "K"
    end
  end
end
