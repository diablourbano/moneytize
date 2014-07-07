require 'test/unit'
require_relative '../lib/simple_currency_format'

class TestSimpleCurrencyFormat < Test::Unit::TestCase
  def test_format_without_decimals
    currency = SimpleCurrencyFormat::CurrencyFormat.format(1025)
    assert_equal('1025.00', currency)
  end

  def test_format_default
    currency = SimpleCurrencyFormat::CurrencyFormat.format(1025.54)
    assert_equal('1025.54', currency)
  end

  def test_format_with_different_symbol
    currency = SimpleCurrencyFormat::CurrencyFormat.format(1025.54, symbol: 'USD')
    assert_equal('USD1025.54', currency)
  end

  def test_format_with_different_decimal_separator
    currency = SimpleCurrencyFormat::CurrencyFormat.format(1025.54, decimal: ',')
    assert_equal('1025,54', currency)
  end

  def test_format_with_different_decimal_separator
    currency = SimpleCurrencyFormat::CurrencyFormat.format(1025.54, decimal: '¢', symbol: '$')
    assert_equal('$1025¢54', currency)
  end

  def test_format_with_different_thousand_separator
    currency = SimpleCurrencyFormat::CurrencyFormat.format(1025.54, thousands: '.', symbol: '$')
    assert_equal('$1.025,54', currency)
  end

  def test_format_with_different_thousand_separator_comma
    currency = SimpleCurrencyFormat::CurrencyFormat.format(1025.54, thousands: ',', decimal: ',', symbol: '$')
    assert_equal('$1,025.54', currency)
  end

  def test_format_with_different_thousand_separator_and_decimal_separator
    currency = SimpleCurrencyFormat::CurrencyFormat.format(1025.54, decimal: ',', thousands: '.', symbol: '$')
    assert_equal('$1.025,54', currency)
  end

  def test_format_with_millions
    currency = SimpleCurrencyFormat::CurrencyFormat.format(14578025.54823424, symbol: '$')
    assert_equal('$14578025.55', currency)
  end

  def test_format_with_millions_separator
    currency = SimpleCurrencyFormat::CurrencyFormat.format(14578025.54823424, millions: true, symbol: '$')
    assert_equal("$14'578025.55", currency)
  end

  def test_format_with_millions_and_thousands_separator
    currency = SimpleCurrencyFormat::CurrencyFormat.format(14578025.54823424, millions: true, thousands: '.', symbol: '$')
    assert_equal("$14'578.025,55", currency)
  end

  def test_billions_with_format_with_millions_and_thousands_separator
    currency = SimpleCurrencyFormat::CurrencyFormat.format(14897456578025.54823424, millions: true, thousands: '.', symbol: '$')
    assert_equal("$14'897.456'578.025,55", currency)
  end

  def test_format_with_hundreds
    currency = SimpleCurrencyFormat::CurrencyFormat.format(125.55, millions: true, thousands: '.', symbol: '$')
    assert_equal('$125,55', currency)
  end

  def test_it_should_allow_only_specific_separators_or_use_default_values
    currency = SimpleCurrencyFormat::CurrencyFormat.format(12589080.78, millions: false, thousands: '*', decimal: '%', symbol: '$')
    assert_equal('$12589080.78', currency)
  end
end
