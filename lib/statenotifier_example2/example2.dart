import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer' as devtools show log;

class ExampleTwo extends ConsumerWidget {
  const ExampleTwo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    devtools.log('BUILD');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example 2'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton(
            // onPressed: ref.read(counterProvider.notifier).increment,
            onPressed: () {
              ref.read(counterProvider.notifier).increment();
              devtools.log('Pressed');
            },
            style: TextButton.styleFrom(
              side: const BorderSide(
                width: 1,
                color: Colors.white,
              ),
            ),
            child: const Text(
              'increment counter',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Consumer(builder: (context, ref, child) {
              final count = ref.watch(counterProvider);
              final text =
                  count == null ? 'Press the button' : count.toString();
              devtools.log('Incremented');
              return Text(
                text,
                style: const TextStyle(
                  fontSize: 25,
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}

class Counter extends StateNotifier<int?> {
  Counter() : super(null);
  void increment() => state = state == null ? 1 : state + 1;
}

final counterProvider = StateNotifierProvider<Counter, int?>(
  (ref) => Counter(),
);

extension OptionalInfixAddition<T extends num> on T? {
  T? operator +(T? other) {
    final shadow = this;
    if (shadow != null) {
      return shadow + (other ?? 0) as T;
    } else {
      return null;
    }
  }
}
