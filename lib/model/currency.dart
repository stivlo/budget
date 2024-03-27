// https://www.iso.org/iso-4217-currency-codes.html
enum Currency {
  // top 10 traded currencies
  // https://www.ig.com/sg/trading-strategies/what-are-the-top-10-most-traded-currencies-in-the-world-200115
  usd('US Dollars', 'USD', '\$', '🇺🇸'),
  eur('Euro', 'EUR', '€', '🇪🇺'),
  jpy('Japanese Yen', 'JPY', 'JP¥', '🇯🇵'),
  gbp('Pound Sterling', 'GBP', '£', '🇬🇧'),
  aud('Australian Dollar', 'AUD', 'A\$', '🇦🇺'),
  cad('Canadian Dollar', 'CAD', 'CA\$', '🇨🇦'),
  chf('Swiss Franc', 'CHF', 'Fr', '🇨🇭'),
  cny('Chinese Yuan', 'CNY', 'CN¥', '🇨🇳'),
  hkd('Hong Kong Dollar', 'HKD', 'HK\$', '🇭🇰'),
  nzd('New Zealand Dollar', 'NZD', 'NZ\$', '🇳🇿'),

  afn('Afghani', 'AFN', 'Af', '🇦🇫'),
  aed('Arab Emirates Dirham', 'AED', 'Dh', '🇦🇪'),
  bhd('Bahrain Dinar', 'BHD', 'BD', '🇧🇭'),
  bdt('Bangladeshi Taka', 'BDT', 'Tk', '🇧🇩'),
  brl('Brazilian Real', 'BRL', 'R\$', '🇧🇷'),
  bgn('Bulgarian Lev', 'BGN', 'лв', '🇧🇬'),
  khr('Cambodian Riel', 'KHR', '៛', '🇰🇭'),
  xpf('CFP Franc', 'XPF', 'F', '🇵🇫'),
  cop('Colombian Peso', 'COP', 'Col\$', '🇨🇴'),
  czk('Czech Koruna', 'CZK', 'Kč', '🇨🇿'),
  dkk('Danish Krone', 'DKK', 'kr.', '🇩🇰'),
  egp('Egyptian Pound', 'EGP', 'E£', '🇪🇬'),
  fjd('Fiji Dollar', 'FJD', 'FJ\$', '🇫🇯'),
  huf('Hungarian Forint', 'HUF', 'Ft', '🇭🇺'),
  inr('Indian Rupee', 'INR', 'Rs.', '🇮🇳'),
  idr('Indonesian Rupiah', 'IDR', 'Rp', '🇮🇩'),
  jod('Jordanian Dinar', 'JOD', 'JD', '🇯🇴'),
  kzt('Kazakh Tenge', 'KZT', '₸', '🇰🇿'),
  krw('Korean Won', 'KRW', '₩', '🇰🇷'),
  kwd('Kuwaiti Dinar', 'KWD', 'KD', '🇰🇼'),
  lak('Lao Kip', 'LAK', '₭', '🇱🇦'),
  myr('Malaysian Ringgit', 'MYR', 'RM', '🇲🇾'),
  mvr('Maldivian Rufiyaa', 'MVR', 'Rf', '🇲🇻'),
  mxn('Mexican Peso', 'MXN', 'Mx\$', '🇲🇽'),
  ngn('Nigerian Naira', 'NGN', '₦', '🇳🇬'),
  nok('Norwegian Krone', 'NOK', 'kr', '🇳🇴'),
  omr('Omani Rial', 'OMR', 'RO.', '🇴🇲'),
  pkr('Pakistan Rupee', 'PKR', 'Rp', '🇵🇰'),
  php('Philippine Peso', 'PHP', '₱', '🇵🇭'),
  pln('Polish Zloty', 'PLN', 'zł', '🇵🇱'),
  qar('Qatari Rial', 'QAR', 'QR', '🇶🇦'),
  ils('Israeli Shekel', 'ILS', '₪', '🇮🇱'),
  ron('Romanian Leu', 'RON', 'lei', '🇷🇴'),
  rub('Russian Ruble', 'RUB', '₽', '🇷🇺'),
  sar('Saudi Riyal', 'SAR', 'SR', '🇸🇦'),
  sgd('Singapore Dollar', 'SGD', 'S\$', '🇸🇬'),
  zar('South African Rand', 'ZAR', 'R', '🇿🇦'),
  lkr('Sri Lanka Rupee', 'LKR', 'රු', '🇱🇰'),
  sek('Swedish Krona', 'SEK', 'kr', '🇸🇪'),
  twd('Taiwan Dollar', 'TWD', 'NT\$', '🇹🇼'),
  thb('Thai Baht', 'THB', '฿', '🇹🇭'),
  try_('Turkish Lira', 'TRY', '₺', '🇹🇷'),
  uah('Ukrainian Grivna', 'UAH', '₴', '🇺🇦'),
  vnd('Vietnamese Dong', 'VND', '₫', '🇻🇳'),
  nul('No currency selected', 'NUL', '', '');

  const Currency(this.name, this.abbreviation, this.symbol, this.flag);
  final String name;
  final String abbreviation;
  final String symbol;
  final String flag;

  static Currency findByAbbreviation(String abbreviation) {
    return Currency.values
        .firstWhere((e) => e.abbreviation == abbreviation, orElse: () => Currency.nul);
  }
}
