import 'package:flutter_anime_list/domain/services/api_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class AnimeEvent {}

class FetchAnimeListEvent extends AnimeEvent {
  late final int animeId;

  FetchAnimeListEvent(this.animeId);
}

// States
abstract class AnimeState {}

class AnimeInitialState extends AnimeState {}

class AnimeLoadedState extends AnimeState {
  final List<dynamic> animeList;

  AnimeLoadedState(
    this.animeList,
  );
}

class AnimeBloc extends Bloc<AnimeEvent, AnimeState> {
  final ApiServices apiService;
  int page;

  AnimeBloc(this.apiService,this.page) : super(AnimeInitialState()) {
    on<FetchAnimeListEvent>((event, emit) async {
      try {
        final animeList = await apiService.fetchAnimeList(page);
        emit(AnimeLoadedState(animeList));
      } catch (error) {
        emit(AnimeInitialState());
      }
    });
    on<FetchAnimeListEvent>((event, emit) async {
      try {
        final characterList =
            await apiService.fetchAnimeListCharacters(event.animeId);
        emit(AnimeLoadedState(characterList));
      } catch (error) {
        emit(AnimeInitialState());
      }
    });
  }
}

class AnimeCubit extends Cubit<AnimeState> {
  final ApiServices _animeService;


  AnimeCubit(this._animeService,) : super(AnimeInitialState());

  Future<void> fetchAnimeList(int page) async {
    try {
      emit(AnimeInitialState());
      final animeList = await _animeService.fetchAnimeList(page);
      emit(AnimeLoadedState(animeList));
    } catch (e) {
      //emit(AnimeError(e.toString()));
    }
  }
}

class CharacterCubit extends Cubit<AnimeState> {
  final ApiServices _animeService;

  CharacterCubit(
    this._animeService,
  ) : super(AnimeInitialState());

  Future<void> fetchCharacterList({int? id}) async {
    try {
      emit(AnimeInitialState());
      final animeList = await _animeService.fetchAnimeListCharacters(id);
      emit(AnimeLoadedState(animeList));
    } catch (e) {
      //emit(AnimeError(e.toString()));
    }
  }
}
