import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ExampleFour extends ConsumerWidget {
  const ExampleFour({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final names = ref.watch(namesProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Stream Provider(Example4)'),
      ),
      body: names.when(
        data: (names) {
          return ListView.builder(
            itemCount: names.length,
            itemBuilder: ((context, index) {
              return ListTile(
                title: Text(names.elementAt(index)),
              );
            }),
          );
        },
        error: (error, stackTrace) =>
            const Text('Opps Reached the End Of the List'),
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

final tickerProvider = StreamProvider(
  (ref) => Stream.periodic(
    const Duration(
      seconds: 1,
    ),
    (i) => i + 1,
    //Because of this this stream is not gonna provide value
    // from 0 its gonna start from 1,
  ),
);

/// The tickerProvider is provideing us with the stream.
/// And the names Provider is giving us all the names.

final namesProvider = StreamProvider(
  (ref) => ref.watch(tickerProvider.stream).map(
        (count) => names.getRange(0, count),
      ),
);

const names = [
  'Abigail',
  'Isaac',
  'Taimoor',
  'Zikria',
  'Mustafa',
  'Thomas',
  'Shahzad',
  'Ammad',
  'Ella',
  'Zoey',
  'Madison',
  'Riley',
  'Scarllet',
  'Hazal',
  'Isla',
  'Mila',
  'Layla',
  'Areej',
  'Arwa',
  'Amira',
];
