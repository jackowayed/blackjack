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
end
