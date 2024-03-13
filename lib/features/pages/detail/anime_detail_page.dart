// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_anime_list/bloc/anime_bloc_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimeDetailPage extends StatefulWidget {
  AnimeDetailPage({Key? key, required this.animeList}) : super(key: key);

  dynamic animeList;

  @override
  _AnimeDetailPageState createState() => _AnimeDetailPageState();
}

class _AnimeDetailPageState extends State<AnimeDetailPage> {
  static const platform =
      MethodChannel('com.example.flutter_anime_list/channel');

  @override
  void initState() {
    super.initState();
    _fetchAnimeList();
    platform.setMethodCallHandler(_handleMethod);
  }

  Future<void> _fetchAnimeList() async {
    try {
      await platform.invokeMethod('fetchAnimeData');
    } on PlatformException catch (e) {
      print("Failed to fetch anime list: '${e.message}'.");
    }
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    if (call.method == 'triggerFetchInFlutter') {
      await context
          .read<CharacterCubit>()
          .fetchCharacterList(id: widget.animeList.malId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterCubit, AnimeState>(
      builder: (context, state) {
        if (state is AnimeLoadedState) {
          final character = state.animeList;
          return Scaffold(
            //backgroundColor: const Color(0xFF070E27),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        buildImage(),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.animeList?.title ?? "Animes"}",
                                maxLines: 2,
                                style: buildTextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Episodes: ${widget.animeList?.episodes}",
                                style: buildTextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 10),
                              buildGenresList(),
                              const SizedBox(height: 20),
                              buildCharacterList(character),
                              const SizedBox(height: 10),
                              Text(
                                "${widget.animeList.synopsis}",
                                style: buildTextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                buildBackButton(context),
              ],
            ),
          );
        } else if (state is AnimeInitialState) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text('Something went wrong!'));
        }
      },
    );
  }

  SizedBox buildCharacterList(List<dynamic> character) {
    return SizedBox(
      height:MediaQuery.of(context).size.height * 0.2,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: character.length,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 10);
        },
        itemBuilder: (context, index) {
          final selectedCharacter = character[index];
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width *0.2 ,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width *0.3,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  child: Image.network(
                    selectedCharacter.character.images?.jpg?.imageUrl ?? "",
                    fit: BoxFit.fill,
                  ),
                ),
                Text(
                  selectedCharacter.character.name ?? "Characters",
                  style: buildTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  SizedBox buildGenresList() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.animeList.genres.length,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 10);
        },
        itemBuilder: (context, index) {
          final genres = widget.animeList.genres[index];
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.deepOrangeAccent,
                width: 1,
              ),
            ),
            child: Text(
              genres?.name ?? "Animes",
              style: buildTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.deepOrangeAccent),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
      ),
    );
  }

  TextStyle buildTextStyle(
      {double? fontSize, FontWeight? fontWeight, Color? color}) {
    return GoogleFonts.roboto(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  Positioned buildBackButton(BuildContext context) {
    return Positioned(
      top: 50,
      left: 20,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        width: 40,
        height: 40,
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.deepOrangeAccent,
            ),
          ),
        ),
      ),
    );
  }

  Stack buildImage() {
    return Stack(
      children: [
        ClipRRect(
          child: AspectRatio(
            aspectRatio: 5 / 7,
            child: Image.network(
              widget.animeList.images?.jpg?.imageUrl ?? "" ?? "",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 50,
          right: 20,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            margin: const EdgeInsets.only(left: 2, top: 8),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            height: 30,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star_border,
                  color: Colors.deepOrange,
                  size: 20,
                ),
                Text(
                  widget.animeList.score.toString() ?? "",
                  style: buildTextStyle(
                      fontSize: 15,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
