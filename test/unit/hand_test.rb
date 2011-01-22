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

    context "#sum" do
      should "return the sum of the cards" do
        assert_equal @hand.cards.reduce(:+), @hand.sum
      end
    end
  end
end
