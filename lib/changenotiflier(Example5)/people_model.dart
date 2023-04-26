import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_revirpod/changenotiflier(Example5)/person_class.dart';

class DataModel extends ChangeNotifier {
  final List<Person> _people = [];

  int get count => _people.length;

  UnmodifiableListView<Person> get people => UnmodifiableListView(_people);

  void add(Person person) {
    _people.add(person);
    notifyListeners();
  }

  void remove(Person person) {
    _people.remove(person);
    notifyListeners();
  }

  void update(Person updatedPerson) {
    final index = _people.indexOf(
      updatedPerson,
    ); //its going through the list and searching equality of the person if its equal than its get the index,

    final oldPerson = _people[
        index]; // if the person name or gae is updated than we will call upbaedPerson function onit,
    if (oldPerson.name != updatedPerson.name ||
        oldPerson.age != updatedPerson.age) {
      _people[index] = oldPerson.updated(
        updatedPerson.name,
        updatedPerson.age,
      );
      notifyListeners();
    }
  }
}
