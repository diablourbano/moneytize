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
      millions_amount = prepare_millions(currency[0])
      thousands = prepare_thousands(millions_amount)
      currency[0] = thousands.join(@millions).reverse!
      currency = currency.join(@decimal)
      "#{@symbol}#{currency}"
    end

    def prepare_millions(amount)
      millions = []
      amount.reverse!

      if amount.size > 6
        final_amount = []

        until amount.size < 6
          final_amount << amount.slice!(0..5)
        end

        final_amount << amount
        millions << final_amount
      else
        millions << amount
      end

      millions
    end

    def prepare_thousands(amount)
      thousands_amount = []
      amount.each do |piece_amount|
        thousands_amount << slice_amount(piece_amount)
      end

      thousands_amount
    end

    def slice_amount(piece_amount)
      final_amount = []
      if piece_amount.size > 2
        until piece_amount.size < 3
          final_amount << piece_amount.slice!(0..2)
        end

        final_amount << piece_amount
        final_amount.join(@thousands)
      else
        piece_amount
      end
    end
  end
end
