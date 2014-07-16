# encoding: utf-8

require 'version'

# Moneytize is a simple formatter for currency, it allows to format any currency the way you like,
# for example, you can decide to separate thousands with ',' and decimals with '.'.
# Please consider that to avoid unnecessary complexity there are a few valid separators: ',', '.', ' ' and '¢'.
# For millions separator you can only choose to use it or not, the separator to be used is "'"
module Moneytize

  # This class is in charge to format any numeric value to the expected currency format.
  class Currency

    # Converts any numeric value to a formatted string based on the conditions (separators) send
    # to the method,
    #
    # The default values are:
    # decimals:        '.'
    # thousands:       ''
    # millions:        false
    # currency_symbol: ''
    #
    # @param value [Numeric] the value to be formatted
    # @param options [Hash] collection of values to be used as separators:
    #   { currency_symbol: '|$|USD|etc|', decimal: "|,|.| |¢|",
    #     thoushands: "|,|.| |", millions: true|false }
    #
    # @return [String] the numeric value formatted to string
    def self.format(value, options = {})
      currency = Currency.new

      currency.prepare_separators(options)
      currency.format_currency_for(value)
    end

    # Prepare decimals, thousands and millions separators based on parameters passed and defaults
    def prepare_separators(options)
      fetch_separators(options)
      validate_separators
    end

    # Formats numeric value to string based on separators previously setted
    def format_currency_for(value)
      currency = format('%0.2f', value).split('.')
      currency[0] = thousands(millions(currency[0])).join(@millions).reverse!

      @currency_symbol.concat(currency.join(@decimal))
    end

    private

    def fetch_separators(options)
      @currency_symbol = options.fetch(:currency_symbol, '')
      @decimal = options.fetch(:decimal, '.')
      @thousands = options.fetch(:thousands, '')
      @millions = "'" if options[:millions]
    end

    def validate_separators
      allowed_symbols = ['.', ',', ' ']

      @decimal = '.' unless allowed_symbols.push('¢').include?(@decimal)
      @thousands = '' unless allowed_symbols.include?(@thousands)

      if @thousands == @decimal
        @decimal = '.' if @thousands == ',' or @thousands == ' '
        @decimal = ',' if @thousands == '.'
      end
    end

    def millions(amount)
      slice_amount(amount.reverse!, 6)
    end

    def thousands(amounts)
      amounts = [amounts] if amounts.is_a?(String)

      amounts.map! { |amount| slice_thousands(amount) }
    end

    def slice_thousands(amount)
      thousand = slice_amount(amount, 3)
      thousand.is_a?(String) ? thousand : thousand.join(@thousands)
    end

    def slice_amount(amount, unit_size)
      return amount unless amount.size > unit_size

      range = unit_size - 1
      min_size = unit_size + 1

      final_amount = []
      final_amount << amount.slice!(0..range) until amount.size < min_size
      final_amount << amount
    end
  end
end
