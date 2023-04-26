//wheather app

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum City {
  tokyo,
  paris,
  peshawar,
}

typedef WeatherEmoji = String;
const unknownWeatherEmoji = '🤷‍♀️';

Future<WeatherEmoji> getWeather(City city) {
  return Future.delayed(
    const Duration(seconds: 1),
    () => {
      City.tokyo: '❄',
      City.paris: '🌧',
      City.peshawar: '⛅',
    }[city]!,
    // both can work
    // [City] ??
    // '❓ No City found',
  );
}

// UI write and read to this
final currentCityProvider = StateProvider<City?>(
  (ref) => null,
);

// UI read this
final weatherProvider = FutureProvider<WeatherEmoji>(
  (ref) {
    final city = ref.watch(currentCityProvider);
    if (city != null) {
      return getWeather(city);
    } else {
      return unknownWeatherEmoji;
    }
  },
);

class ExampleThree extends ConsumerWidget {
  const ExampleThree({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeather = ref.watch(
      weatherProvider,
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Weather(Example 3)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            currentWeather.when(
              data: (data) => Text(
                data,
                style: const TextStyle(
                  fontSize: 50,
                ),
              ),
              error: (_, __) => const Text('error 😢'),
              loading: () => const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 7.5,
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: ListView.builder(
                  itemCount: City.values.length,
                  itemBuilder: (context, index) {
                    final city = City.values[index];
                    final isSelected = city == ref.watch(currentCityProvider);
                    return ListTile(
                      title: Text(
                        city.toString(),
                      ),
                      trailing: isSelected ? const Icon(Icons.check) : null,
                      onTap: () => ref
                          .read(
                            currentCityProvider.notifier,
                          )
                          .state = city,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
