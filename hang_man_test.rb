require_relative 'hang_man'
require 'test/unit'

# Basic testing framework for Hangman
class HangManTest < Test::Unit::TestCase

  def testInitialize
    h = HangMan.new
    assert_equal(h.count, 9)
    assert_equal(h.comp_guess.size,h.user_guess.size)
  end

  def testDefaultTypes
    h = HangMan.new
    assert_kind_of(String,h.comp_guess)
    assert_kind_of(Array,h.user_guess)
    h.user_guess.each {|i| assert_equal(i,nil)}
    assert_kind_of(Array,h.guess)
    assert_kind_of(Array,h.misses)
  end

end