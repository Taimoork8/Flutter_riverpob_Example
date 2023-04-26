///
/// In thios Example i have work on where i can get person name
/// and age and assign a uuid to it and the person can update tier age and name
/// on taping on the thier name.
///
///ChangeNotifier
///changenotifierProvider
///

import 'package:flutter/material.dart';
import 'package:flutter_revirpod/changenotiflier(Example5)/alert_dialog.dart';
import 'package:flutter_revirpod/changenotiflier(Example5)/people_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final peopleProvider = ChangeNotifierProvider(
  (ref) => DataModel(),
);

class ExampleFive extends ConsumerWidget {
  const ExampleFive({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Example 5'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final dataModel = ref.watch(peopleProvider);
          return ListView.builder(
            itemCount: dataModel.count,
            itemBuilder: (context, index) {
              final person = dataModel.people[index];
              return ListTile(
                title: GestureDetector(
                  onTap: () async {
                    final updatedPerson = await createOrUpdatePersonDialog(
                      context,
                      person,
                    );
                    if (updatedPerson != null) {
                      dataModel.update(updatedPerson);
                    }
                  },
                  child: Text(person.displayName),
                ),
                trailing: IconButton(
                  onPressed: () {
                    ref.read(peopleProvider).remove(person);
                  },
                  icon: const Icon(Icons.delete),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FloatingActionButton(
          onPressed: () async {
            final addPerson = await createOrUpdatePersonDialog(
              context,
            );
            if (addPerson != null) {
              final dataModel = ref.read(peopleProvider);
              dataModel.add(addPerson);
            }
          },
          child: const Icon(
            Icons.add,
            size: 40,
          ),
        ),
      ),
    );
  }
}
