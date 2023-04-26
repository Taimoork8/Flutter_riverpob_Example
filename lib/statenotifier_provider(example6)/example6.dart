///
/// In this Example Well talk about StateNotifierProvider
///

import 'package:flutter/material.dart';
import 'package:flutter_revirpod/statenotifier_provider(example6)/enum.dart';
import 'package:flutter_revirpod/statenotifier_provider(example6)/film_class.dart';
import 'package:flutter_revirpod/statenotifier_provider(example6)/film_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//favorite status
final favoriteStatusProvider = StateProvider<FavoriteStatus>(
  (ref) => FavoriteStatus.all,
);

// All films
final allFilmsProvider = StateNotifierProvider<FilmsNotifier, List<Film>>(
  (ref) => FilmsNotifier(),
);

//favorite films
final favoriteFilmsProvider = Provider<Iterable<Film>>(
  (ref) => (ref).watch(allFilmsProvider).where(
        (film) => film.isFavorite,
      ),
);

//not favorite films
final notfavoriteFilmsProvider = Provider<Iterable<Film>>(
  (ref) => (ref).watch(allFilmsProvider).where(
        (film) => !film.isFavorite,
      ),
);

class ExampleSix extends ConsumerWidget {
  const ExampleSix({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Film "Example 6"'),
      ),
      body: Column(
        children: [
          const Center(child: FilterWidget()),
          Consumer(
            builder: (context, ref, child) {
              final filter = ref.watch(favoriteStatusProvider);
              switch (filter) {
                case FavoriteStatus.all:
                  return FilmsWidget(provider: allFilmsProvider);
                case FavoriteStatus.favorite:
                  return FilmsWidget(provider: favoriteFilmsProvider);
                case FavoriteStatus.notFavorite:
                  return FilmsWidget(provider: notfavoriteFilmsProvider);
              }
            },
          ),
        ],
      ),
    );
  }
}

class FilmsWidget extends ConsumerWidget {
  final AlwaysAliveProviderBase<Iterable<Film>> provider;
  const FilmsWidget({
    required this.provider,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final films = ref.watch(provider);
    return Expanded(
      child: ListView.builder(
        itemCount: films.length,
        itemBuilder: (context, index) {
          final film = films.elementAt(index);
          final favoriteIcon = film.isFavorite
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border);
          return ListTile(
            title: Text(film.title),
            subtitle: Text(film.description),
            trailing: IconButton(
              onPressed: () {
                final isFavorite = !film.isFavorite;
                ref.read(allFilmsProvider.notifier).updateF(
                      film,
                      isFavorite,
                    );
              },
              icon: favoriteIcon,
            ),
          );
        },
      ),
    );
  }
}

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return DropdownButton(
          value: ref.watch(favoriteStatusProvider),
          items: FavoriteStatus.values
              .map(
                (fs) => DropdownMenuItem(
                  value: fs,
                  child: Text(
                    fs.toString().split('.').last,
                  ),
                ),
              )
              .toList(),
          onChanged: (fs) {
            ref
                .read(
                  favoriteStatusProvider.notifier,
                )
                .state = fs!;
          },
        );
      },
    );
  }
}
