module Cards
  def card_string(card)
    case card
    when 1: "A"
    when 2..10: card
    when 11: "J"
    when 12: "Q"
    when 13: "K"
    end
  end
end
