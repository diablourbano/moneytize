require 'test/unit'
require_relative '../lib/simple_currency_format'

class TestSimpleCurrencyFormat < Test::Unit::TestCase
  def test_format_default
    currency = SimpleCurrencyFormat::CurrencyFormat.format(1025.54)
    assert_equal("$1025.54", currency)
  end

  def test_format_with_different_symbol
    currency = SimpleCurrencyFormat::CurrencyFormat.format(1025.54, {with_symbol: 'USD'})
    assert_equal("USD1025.54", currency)
  end

  def test_format_with_different_decimal_separator
    currency = SimpleCurrencyFormat::CurrencyFormat.format(1025.54, {decimal: ','})
    assert_equal("$1025,54", currency)
  end

  def test_format_with_different_thousand_separator
    currency = SimpleCurrencyFormat::CurrencyFormat.format(1025.54, {thousands: '.'})
    assert_equal("$1.025,54", currency)
  end

  def test_format_with_different_thousand_separator_and_decimal_separator
    currency = SimpleCurrencyFormat::CurrencyFormat.format(1025.54, {decimal: ',', thousands: '.'})
    assert_equal("$1.025,54", currency)
  end

  def test_format_with_millions
    currency = SimpleCurrencyFormat::CurrencyFormat.format(14578025.54823424)
    assert_equal("$14578025.55", currency)
  end

  def test_format_with_millions_separator
    currency = SimpleCurrencyFormat::CurrencyFormat.format(14578025.54823424, {millions: true})
    assert_equal("$14'578025.55", currency)
  end

  def test_format_with_millions_and_thousands_separator
    currency = SimpleCurrencyFormat::CurrencyFormat.format(14578025.54823424, {millions: true, thousands: '.'})
    assert_equal("$14'578.025.55", currency)
  end
end
