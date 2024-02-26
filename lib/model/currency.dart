// https://www.iso.org/iso-4217-currency-codes.html
enum Currency {
  // top 10 traded currencies
  // https://www.ig.com/sg/trading-strategies/what-are-the-top-10-most-traded-currencies-in-the-world-200115
  usd('US Dollars', 'USD', '\$'),
  eur('Euro', 'EUR', '€'),
  jpy('Japanese Yen', 'JPY', 'JP¥'),
  gbp('Pound Sterling', 'GBP', '£'),
  aud('Australian Dollar', 'AUD', 'A\$'),
  cad('Canadian Dollar', 'CAD', 'CA\$'),
  chf('Swiss Franc', 'CHF', 'Fr'),
  cny('Chinese Yuan', 'CNY', 'CN¥'),
  hkd('Hong Kong Dollar', 'HKD', 'HK\$'),
  nzd('New Zealand Dollar', 'NZD', 'NZ\$'),

  afn('Afghani', 'AFN', '؋'),
  all('Lek', 'ALL', 'L'),
  dzd('Algerian Dinar', 'DZD', 'دج'),
  aoa('Kwanza', 'AOA', 'Kz'),
  xcd('East Caribbean Dollar', 'XCD', 'EC\$'),
  ars('Argentine Peso', 'ARS', '\$'),
  amd('Armenian Dram', 'AMD', 'Դ'),
  awg('Aruba Florin', 'AWG', 'ƒ'),

  azn('Azerbaijan Manat', 'AZN', '₼'),
  bsd('Bahamian Dollar', 'bsd', 'B\$'),
  bhd('Bahraini Dinar', 'BHD', '.د.ب'),
  bdt('Taka', 'BDT', 'Tk'),

  thb('Thai Baht', 'THB', '฿');

  const Currency(this.name, this.abbreviation, this.symbol);
  final String name;
  final String abbreviation;
  final String symbol;
}
