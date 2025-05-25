enum Currency {
  usd,
  eur,
  inr,
  jpy,
  gbp,
}

extension CurrencyExtension on Currency {
  String get label {
    switch (this) {
      case Currency.usd:
        return 'USD';
      case Currency.eur:
        return 'EUR';
      case Currency.inr:
        return 'INR';
      case Currency.jpy:
        return 'JPY';
      case Currency.gbp:
        return 'GBP';
    }
  }

  String get symbol {
    switch (this) {
      case Currency.usd:
        return '\$';
      case Currency.eur:
        return '€';
      case Currency.inr:
        return '₹';
      case Currency.jpy:
        return '¥';
      case Currency.gbp:
        return '£';
    }
  }
}
