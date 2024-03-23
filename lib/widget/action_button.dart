import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(label),
    );
  }
}
