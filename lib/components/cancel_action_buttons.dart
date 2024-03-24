import 'package:flutter/cupertino.dart';

import '../widget/action_button.dart';
import '../widget/cancel_button.dart';

class CancelActionButtons extends StatelessWidget {
  const CancelActionButtons({required this.actionLabel, this.action, super.key});

  final VoidCallback? action;
  final String actionLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CancelButton(Navigator.of(context)),
        ActionButton(label: actionLabel, onPressed: action),
      ],
    );
  }
}
