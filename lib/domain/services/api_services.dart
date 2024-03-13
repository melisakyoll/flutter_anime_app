import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_anime_list/data/model/anime_model/anime_data_model.dart';
import 'package:flutter_anime_list/data/model/characters_model/characters_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static const platform =
      MethodChannel('com.example.flutter_anime_list/channel');

  Future<List<Anime>> fetchAnimeList(int page) async {
    const baseUrl = 'https://api.jikan.moe/v4/top/anime?page={page}&limit=8';
    String formattedUrl = baseUrl.replaceAll('{page}', page.toString());

    final response = await http.get(
      Uri.parse(formattedUrl),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> animeNodeList = data['data'];
      final animes = animeNodeList
          .where(
        (animeNode) => animeNode != null,
      )
          .map(
        (node) {
          return Anime.fromJson(node);
        },
      ).toList(); // Convert Iterable to List

      return animes;
    } else {
      /*debugPrint("Error: ${response.statusCode}");
    debugPrint("Body: ${response.body}");*/
      throw Exception("Failed to get data!");
    }
  }

  Future<List<CharacterModel>> fetchAnimeListCharacters(int? id) async {
    const baseUrl = 'https://api.jikan.moe/v4/anime/{id}/characters';

    String formattedUrl = baseUrl.replaceAll('{id}', id.toString());

    final response = await http.get(
      Uri.parse(formattedUrl),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> characterList = data['data'];
      final characters = characterList
          .where(
            (characterNode) => characterNode != null,
      )
          .map(
            (node) {
          return CharacterModel.fromJson(node);
        },
      )
          .toList(); // Convert Iterable to List

      return characters;
    } else {
      throw Exception("Failed to get data!");
    }
  }
}
