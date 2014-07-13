require 'minitest/autorun'
require_relative '../lib/moneytize'

class TestMoneytize < MiniTest::Unit::TestCase
  def test_format_without_decimals
    currency = Moneytize::Currency.format(1025)
    assert_equal('1025.00', currency)
  end

  def test_format_default
    currency = Moneytize::Currency.format(1025.54)
    assert_equal('1025.54', currency)
  end

  def test_format_with_different_symbol
    currency = Moneytize::Currency.format(1025.54, currency_symbol: 'USD')
    assert_equal('USD1025.54', currency)
  end

  def test_format_with_different_decimal_separator
    currency = Moneytize::Currency.format(1025.54, decimal: ',')
    assert_equal('1025,54', currency)
  end

  def test_format_with_different_decimal_separator_and_currency_symbol
    currency = Moneytize::Currency.format(1025.54, decimal: '¢', currency_symbol: '$')
    assert_equal('$1025¢54', currency)
  end

  def test_format_with_different_thousand_separator
    currency = Moneytize::Currency.format(1025.54, thousands: '.', currency_symbol: '$')
    assert_equal('$1.025,54', currency)
  end

  def test_format_with_different_thousand_separator_comma
    currency = Moneytize::Currency.format(1025.54, thousands: ',', decimal: ',', currency_symbol: '$')
    assert_equal('$1,025.54', currency)
  end

  def test_format_with_different_thousand_separator_and_decimal_separator
    currency = Moneytize::Currency.format(1025.54, decimal: ',', thousands: '.', currency_symbol: '$')
    assert_equal('$1.025,54', currency)
  end

  def test_format_with_millions
    currency = Moneytize::Currency.format(14578025.54823424, currency_symbol: '$')
    assert_equal('$14578025.55', currency)
  end

  def test_format_with_millions_separator
    currency = Moneytize::Currency.format(14578025.54823424, millions: true, currency_symbol: '$')
    assert_equal("$14'578025.55", currency)
  end

  def test_format_with_millions_and_thousands_separator
    currency = Moneytize::Currency.format(14578025.54823424, millions: true, thousands: '.', currency_symbol: '$')
    assert_equal("$14'578.025,55", currency)
  end

  def test_billions_with_format_with_millions_and_thousands_separator
    currency = Moneytize::Currency.format(14897456578025.54823424, millions: true, thousands: '.', currency_symbol: '$')
    assert_equal("$14'897.456'578.025,55", currency)
  end

  def test_format_with_hundreds
    currency = Moneytize::Currency.format(125.55, millions: true, thousands: '.', currency_symbol: '$')
    assert_equal('$125,55', currency)
  end

  def test_it_should_allow_only_specific_separators_or_use_default_values
    currency = Moneytize::Currency.format(12589080.78, millions: false, thousands: '*', decimal: '%', currency_symbol: '$')
    assert_equal('$12589080.78', currency)
  end
end
