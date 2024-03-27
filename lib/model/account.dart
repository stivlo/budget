import 'currency.dart';

class Account {
  Account({required this.id, required this.name, required this.currency});

  static const nameMaxLength = 30;

  final int id;
  final String name;
  final Currency currency;
}
