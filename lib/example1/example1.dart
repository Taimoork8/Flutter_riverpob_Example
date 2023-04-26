import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExampleOne extends ConsumerWidget {
  const ExampleOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(currentDate);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Hooks Riverpod Example'),
      ),
      body: Center(
        child: Text(
          date.toIso8601String(),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}

final currentDate = Provider<DateTime>(
  (ref) => DateTime.now(),
);
