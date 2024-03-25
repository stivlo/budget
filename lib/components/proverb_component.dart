import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/proverb_provider.dart';

class ProverbComponent extends ConsumerWidget {
  const ProverbComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String proverb = ref.watch(proverbProvider);
    return Card(
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.all(12),
        width: double.infinity,
        child: Text(proverb),
      ),
    );
  }
}
