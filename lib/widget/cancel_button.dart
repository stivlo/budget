import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  const CancelButton(this.navigatorState, {super.key});

  final NavigatorState navigatorState;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => navigatorState.pop(),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(220, 220, 220, 1),
        foregroundColor: Colors.black,
      ),
      child: const Text('Cancel'),
    );
  }
}
