require 'version'

module SimpleCurrencyFormat
  class CurrencyFormat
    def self.format(value, options={})
      currency = CurrencyFormat.new(value)
      currency.prepare_separators(options)
      currency.format_currency
    end

    def initialize(value)
      @value = value
    end

    def prepare_separators(options)
      @symbol = options.fetch(:symbol, '')
      @thousands = options.fetch(:thousands, '')
      @decimal = options.fetch(:decimal, '.')

      @decimal = ',' if @thousands == '.' and @decimal == '.'
      @millions = "'" if options[:millions]
    end
    :wa

    def format_currency
      currency = sprintf("%0.2f", @value).split(".")
      currency[0] = thousands(millions(currency[0])).join(@millions).reverse!

      @symbol.concat(currency.join(@decimal))
    end

    def millions(amount)
      slice_millions(amount.reverse!)
    end

    def thousands(amounts)
      amounts = [amounts] if amounts.is_a?(String)

      amounts.collect! do |amount|
        slice_thousands(amount)
      end
    end

    private
    
    def slice_millions(amount)
      slice_amount(amount, 6)
    end

    def slice_thousands(amount)
      thousand = slice_amount(amount)
      thousand.is_a?(String) ? thousand : thousand.join(@thousands)
    end

    def slice_amount(amount, unit_size=3)
      return amount unless amount.size > unit_size

      range = unit_size - 1
      min_size = unit_size + 1

      final_amount = []
      final_amount << amount.slice!(0..range) until amount.size < min_size
      final_amount << amount
    end
  end
end
