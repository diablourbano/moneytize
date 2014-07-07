# MONEYTIZE
Did you ever have the requirement:
> Can you format the value as currency with "," as decimal separator

or

> Can you display " ' " as millions separator

It's not too hard to parse a numeric value to format it the way you want,
but why would you like to repeat the same process every time you need to parse
a numeric value as currency.

*_THAT'S WHY MONEYTIZE EXISTS_*

Just call it with the value to be formatted and the options you expect:
```
Moneytize::Currency.format(123456.9803, { currency_symbol: '$', decimal: ',' })
```

Check the [documentation](http://www.moneytize.me) to see the options you have.
