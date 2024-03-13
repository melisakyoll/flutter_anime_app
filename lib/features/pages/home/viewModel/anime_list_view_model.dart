import 'package:flutter/material.dart';
import 'package:flutter_anime_list/bloc/anime_bloc_bloc.dart';

import '../../../../data/model/anime_model/anime_data_model.dart';

class AnimeListViewModel extends ChangeNotifier {
  final AnimeCubit _animeCubit;
  List<Anime> _animeList = [];
  List<Anime> get animeList => _animeList;

  AnimeListViewModel(this._animeCubit) {
    _animeCubit.stream.listen((state) {
      if (state is AnimeLoadedState) {
        // Explicitly cast the list elements to Anime type
        _animeList = state.animeList.cast<Anime>();
        notifyListeners();
      }
    });
    fetchAnimeList();
  }

  void fetchAnimeList() {
    _animeCubit.fetchAnimeList(1); // Assuming starting page is 1
  }

  void fetchNextPage(int nextPage) {
    _animeCubit.fetchAnimeList(nextPage);
  }

  void fetchPreviousPage(int previousPage) {
    if (previousPage > 0) {
      _animeCubit.fetchAnimeList(previousPage);
    }
  }
}
