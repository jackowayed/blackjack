#!/usr/bin/env ruby

require File.join(File.dirname(__FILE__), '../test_helper')

class HandTest < Test::Unit::TestCase
  context "a hand" do
    setup do
      @deck = Deck.new
      @hand = Hand.new @deck
    end

    should "start with two cards" do
      assert_equal 2, @hand.cards.length
    end

    should "start with stood == false" do
      assert_equal false, @hand.stood?
    end

    context "#hit" do

      setup do
        @cards_before = @hand.cards.dup
        @hand.hit @deck
      end

      should "add a card to the deck" do
        assert_equal @cards_before.length + 1, @hand.cards.length
      end

      should "add the card to the end of the array" do
        assert_equal @cards_before, @hand.cards[0...-1]
      end
    end

    context "#final_sum" do
      should "return the sum of the cards" do
        @hand.cards = [2,3]
        assert_equal 5, @hand.final_sum
      end

      should "value face cards as 10" do
        @hand.cards = [13, 11]
        assert_equal 20, @hand.final_sum
      end

      should "value aces as 11 when that doesn't bust them" do
        @hand.cards = [1, 4]
        assert_equal 15, @hand.final_sum
      end

      should "value aces as 1 when valuing them as 11 would bust them" do
        @hand.cards = [1,1,1]
        assert_equal 13, @hand.final_sum
      end

      should "value aces as 1 when they're busted regardless" do
        @hand.cards = [13, 5, 1, 12]
        assert_equal 26, @hand.final_sum
      end
    end

    context "#stand" do
      setup do
        assert_equal false, @hand.stood?
        @hand.stand
      end

      should "set stood to true" do
        assert @hand.stood
      end
    end

    context "#result" do
      setup do
        @dealer = Hand.new @deck
      end

      should "return -1 if the player is greater than 21, regardless" do
        @hand.cards = [11, 5, 13]
        @dealer.cards = [11, 3, 13]
        assert_equal -1, @hand.result(@dealer)
      end

      should "return -1 if the player is less than the dealer" do
        @hand.cards = [12, 7]
        @dealer.cards = [10, 8]
        assert_equal -1, @hand.result(@dealer)
      end

      should "return 0 if the player is equal to the dealer" do
        @hand.cards = [12, 7]
        @dealer.cards = [10, 7]
        assert_equal 0, @hand.result(@dealer)
      end

      should "return 1 if the player is greater than the dealer" do
        @hand.cards = [12, 8]
        @dealer.cards = [10, 7]
        assert_equal 1, @hand.result(@dealer)
      end

      should "return 1 if the dealer goes bust and player doesn't" do
        @hand.cards = [2,3]
        @dealer.cards = [10, 5, 10]
        assert_equal 1, @hand.result(@dealer)
      end
    end

    context "#double_down" do
      setup do
        assert_equal false, @hand.stood?
        @hand.stand
      end

      should "stand" do
        assert @hand.stood
      end
    end

    context "#blackjack" do
      should "return false for hands that don't equal 21" do
        @hand.cards = [10, 10]
        assert_equal false, @hand.blackjack?
      end

      should "return false for hands that add up to 21 but aren't just an Ace and a 10-valued card" do
        @hand.cards = [5,5,5,4,2]
        assert_equal false, @hand.blackjack?
      end

      should "return true for hands with an Ace and a 10-valued card" do
        @hand.cards = [1, 10]
        assert @hand.blackjack?
        @hand.cards = [12, 1]
        assert @hand.blackjack?
      end
    end
  end
end
