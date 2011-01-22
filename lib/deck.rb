class Deck
  def initialize
    reset_deck
  end

  def draw
    # reshuffle if the shoe gets too small
    reset_deck if @cards.length < 26

    @cards.delete_at rand(@cards.length)
  end

  def reset_deck
    # shoe of 10 decks
    @cards = Array(1..13) * 10
  end
end
