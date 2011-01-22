class Game
  attr_accessor :chips

  def initialize
    @chips = 500
    @deck = Deck.new
  end
end
