// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_anime_list/bloc/anime_bloc_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../domain/services/api_services.dart';
import '../detail/anime_detail_page.dart';
import 'components/home_page_grid_view.dart'; // Ensure this path is correct

class AnimeListPage extends StatefulWidget {
  AnimeListPage({Key? key}) : super(key: key);
  int page = 1;

  @override
  _AnimeListPageState createState() => _AnimeListPageState();
}

class _AnimeListPageState extends State<AnimeListPage> {
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
      await context.read<AnimeCubit>().fetchAnimeList(widget.page);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color(0xFF070E27),
      appBar: AppBar(
        systemOverlayStyle:
        const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        title: Text(
          'The Anime Corner',
          style: buildTextStyle(
              color: Colors.deepOrangeAccent,
              fontWeight: FontWeight.w800,
              fontSize: 25),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<AnimeCubit, AnimeState>(
        builder: (context, state) {
          if (state is AnimeLoadedState) {
            final anime = state.animeList;
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  buildButton(context),
                  animeListWidget(state,anime),
                ],
              ),
            );
          } else if (state is AnimeInitialState) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text('Something went wrong!'));
          }
        },
      ),
    );
  }

  Expanded animeListWidget(AnimeLoadedState state,final anime) {
    return Expanded(
      flex: 16,
      child: HomePageGridView(state: state.animeList,onTap: (){
        final ApiServices apiServices = ApiServices();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider<CharacterCubit>(
              create: (context) => CharacterCubit(apiServices),
              child: AnimeDetailPage(
                animeList: anime,
              ),
            ),
          ),
        );
      },),
    );
  }

  Expanded buildButton(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () async {
                if (widget.page != 1) {
                  widget.page--;
                  await context.read<AnimeCubit>().fetchAnimeList(widget.page);
                }
              },
              child: Text(
                "Önceki Liste",
                style: buildTextStyle(
                    fontSize: 20, color: Colors.deepOrangeAccent),
              ),
            ),
            InkWell(
              onTap: () async {
                widget.page++;
                await context.read<AnimeCubit>().fetchAnimeList(widget.page);
              },
              child: Text(
                "Sonraki Liste",
                style: buildTextStyle(
                    fontSize: 20, color: Colors.deepOrangeAccent),
              ),
            ),
          ],
        ),
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
}

