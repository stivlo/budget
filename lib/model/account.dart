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

  static String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Provide an account name';
    }
    return null;
  }

  Account copyWith({
    String? name,
  }) =>
      Account(
        id: id,
        name: name ?? this.name,
        currency: currency,
      );

  @override
  String toString() {
    return 'Account{id: $id, name: $name, currency: ${currency.abbreviation}}';
  }
}
