import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

@immutable
class Person {
  final String name;
  final int age;
  final String uuid;

  Person({
    required this.name,
    required this.age,
    String? uuid,
  }) : uuid = uuid ?? const Uuid().v4();

  Person updated([String? name, int? age]) => Person(
        name: name ?? this.name,
        age: age ?? this.age,
        uuid: uuid,
      );

  String get displayName => '$name ($age years old)';

  @override
  //its means that if the person uuid match when he or she edited the list than it will update the previce one.
  bool operator ==(covariant Person other) => uuid == other.uuid;

  @override
  int get hashCode =>
      uuid.hashCode; // this for just to return the hashcode of uuid,
  // int get hashCode => Object.hash(name, age, uuid);//this is for all.

  @override
  String toString() => 'Person(name: $name, age:$age, uuid: $uuid)';
}
