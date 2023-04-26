import 'package:flutter/material.dart';
import 'package:flutter_revirpod/changenotiflier(Example5)/person_class.dart';

final nameController = TextEditingController();
final ageController = TextEditingController();

Future<Person?> createOrUpdatePersonDialog(
  BuildContext context, [
  Person? existingPerson,
]) {
  String? name = existingPerson?.name;
  int? age = existingPerson?.age;

  nameController.text = name ?? '';
  ageController.text = age?.toString() ?? '';

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Create a Person'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Enter name here...'),
              onChanged: (value) => name = value,
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(hintText: 'Enter age here...'),
              // onChanged: (value) => age = value as int?,
              onChanged: (value) => age = int.parse(value),
              //we can do both.
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (name != null && age != null) {
                if (existingPerson != null) {
                  //we have existing person
                  final newPerson = existingPerson.updated(
                    name,
                    age,
                  );
                  Navigator.of(context).pop(
                    newPerson,
                  );
                } else {
                  //no existing person, create a new one,
                  Navigator.of(context).pop(
                    Person(
                      name: name!,
                      age: age!,
                    ),
                  );
                }
              } else {
                //nothinf given name nor age,
                Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
