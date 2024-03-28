import 'currency.dart';

class Account {
  Account({required this.id, required this.name, required this.currency});
  Account.fromMap(Map<String, dynamic> map)
      : id = map['id'] as int,
        name = map['name'] as String,
        currency = Currency.findByAbbreviation(map['currency'] as String);

  static const nameMaxLength = 22;

  final int id;
  final String name;
  final Currency currency;

  @override
  String toString() {
    return 'Account{id: $id, name: $name, currency: ${currency.abbreviation}}';
  }
}
