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
      @symbol = options[:with_symbol] || '$'
      if options[:millions]
        @millions = "'"
      end
      @thousands = options[:thousands]
      @decimal = options[:decimal] || '.'

      @decimal = ',' if @thousands == '.' and @decimal == '.'
    end

    def format_currency
      currency = sprintf("%0.2f", @value).split(".")
      currency[0] = thousands(millions(currency[0])).join(@millions).reverse!

      @symbol.concat(currency.join(@decimal))
    end

    def millions(amount)
      [ slice_amount(amount.reverse!, 6, false) ]
    end

    def thousands(amounts)
      amounts.collect! { |amount| slice_amount(amount, 3, true) }
    end

    def slice_amount(amount, unit_size, join_thousands)
      return amount unless amount.size > unit_size

      range = unit_size - 1
      min_size = unit_size + 1

      final_amount = []
      final_amount << amount.slice!(0..range) until amount.size < min_size
      final_amount << amount

      if join_thousands
        final_amount.join(@thousands)
      else
        final_amount
      end
    end
  end
end
