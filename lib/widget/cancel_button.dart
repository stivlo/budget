import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(220, 220, 220, 1),
        foregroundColor: Colors.black,
      ),
      child: const Text('Cancel'),
    );
  }
}
