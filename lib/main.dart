import 'package:flutter/material.dart';
import 'package:flutter_revirpod/statenotifier_provider(example6)/example6.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  runApp(
    ProviderScope(
      child: MaterialApp(
        title: 'RiverPod Example state management',
        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        // ),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        home: const ExampleSix(),
      ),
    ),
  );
}
