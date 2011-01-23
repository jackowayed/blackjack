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
  end
end
