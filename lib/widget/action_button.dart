import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({required this.label, this.onPressed, super.key});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
