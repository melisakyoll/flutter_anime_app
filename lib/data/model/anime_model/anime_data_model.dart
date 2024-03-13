import 'genres_model.dart';
import 'images_model.dart';

class Anime {
  int? malId;
  String? url;
  Images? images;
  bool? approved;
  String? title;
  String? titleEnglish;
  String? titleJapanese;
  String? type;
  String? source;
  int? episodes;
  String? status;
  bool? airing;
  String? duration;
  String? rating;
  double? score;
  int? scoredBy;
  int? rank;
  int? popularity;
  int? members;
  int? favorites;
  String? synopsis;
  String? background;
  String? season;
  int? year;
  List<Genres>? genres;

  Anime({
    this.malId,
    this.images,
    this.title,
    this.rating,
    this.type,
    this.synopsis,
    this.episodes,
    this.genres,
    this.score,
    this.season,
    this.airing,
    this.approved,
    this.background,
    this.duration,
    this.favorites,
    this.members,
    this.popularity,
    this.rank,
    this.scoredBy,
    this.source,
    this.status,
    this.titleEnglish,
    this.titleJapanese,
    this.url,
    this.year,
  });

  Anime.fromJson(DataMap json) {
    malId = json['mal_id'];
    url = json['url'];
    images = Images.fromJson(json['images']);
    approved = json['approved'];
    title = json['title'];
    titleEnglish = json['title_english'];
    titleJapanese = json['title_japanese'];
    type = json['type'];
    source = json['source'];
    episodes = json['episodes'];
    status = json['status'];
    airing = json['airing'];
    duration = json['duration'];
    rating = json['rating'];
    score = json['score'];
    scoredBy = json['scored_by'];
    rank = json['rank'];
    popularity = json['popularity'];
    members = json['members'];
    favorites = json['favorites'];
    synopsis = json['synopsis'];
    background = null;
    season = null;
    year = null;

    genres = List.from(json['genres']).map((e) => Genres.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mal_id'] = malId;
    _data['url'] = url;
    _data['images'] = images?.toJson();
    _data['approved'] = approved;
    _data['title'] = title;
    _data['title_english'] = titleEnglish;
    _data['title_japanese'] = titleJapanese;
    _data['type'] = type;
    _data['source'] = source;
    _data['episodes'] = episodes;
    _data['status'] = status;
    _data['airing'] = airing;
    _data['duration'] = duration;
    _data['rating'] = rating;
    _data['score'] = score;
    _data['scored_by'] = scoredBy;
    _data['rank'] = rank;
    _data['popularity'] = popularity;
    _data['members'] = members;
    _data['favorites'] = favorites;
    _data['synopsis'] = synopsis;
    _data['background'] = background;
    _data['season'] = season;
    _data['year'] = year;
    _data['genres'] = genres?.map((e) => e.toJson()).toList();

    return _data;
  }
}

typedef DataMap = Map<String, dynamic>;

class Character {
  final String imageUrl;
  final String name;

  Character({required this.imageUrl, required this.name});
}
