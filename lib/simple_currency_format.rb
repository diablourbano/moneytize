require 'version'

module SimpleCurrencyFormat
  class CurrencyFormat
    def self.format(value, options = {})
      currency = CurrencyFormat.new

      currency.prepare_separators(options)
      currency.format_currency_for(value)
    end

    def prepare_separators(options)
      fetch_separators(options)
      validate_separators
    end

    def format_currency_for(value)
      currency = format('%0.2f', value).split('.')
      currency[0] = thousands(millions(currency[0])).join(@millions).reverse!

      @symbol.concat(currency.join(@decimal))
    end

    def millions(amount)
      slice_millions(amount.reverse!)
    end

    def thousands(amounts)
      amounts = [amounts] if amounts.is_a?(String)

      amounts.map! do |amount|
        slice_thousands(amount)
      end
    end

    private

    def fetch_separators(options)
      @symbol = options.fetch(:symbol, '')
      @decimal = options.fetch(:decimal, '.')
      @thousands = options.fetch(:thousands, '')
      @millions = "'" if options[:millions]
    end

    def validate_separators
      allowed_symbols = ['.', ',', ' ']

      @decimal = '.' unless allowed_symbols.push('¢').include?(@decimal)
      @thousands = '' unless allowed_symbols.include?(@thousands)

      @decimal = ',' if @thousands == '.' && @decimal == '.'
      @thousands = '.' if @thousands == ',' && @decimal == ','
    end

    def slice_millions(amount)
      slice_amount(amount, 6)
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
