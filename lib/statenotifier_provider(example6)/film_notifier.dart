import 'package:flutter_revirpod/statenotifier_provider(example6)/constant_film_name.dart';
import 'package:flutter_revirpod/statenotifier_provider(example6)/film_class.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FilmsNotifier extends StateNotifier<List<Film>> {
  FilmsNotifier() : super(allFilms);

  void updateF(Film film, bool isFavorite) {
    state = state
        .map((thisFilm) => thisFilm.id == film.id
            ? thisFilm.copy(
                isFavorite: isFavorite,
              )
            : thisFilm)
        .toList();
  }
}
