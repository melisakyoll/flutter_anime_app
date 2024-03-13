// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../bloc/anime_bloc_bloc.dart';
import '../../../../data/model/anime_model/anime_data_model.dart';
import '../../../../domain/services/api_services.dart';
import '../../detail/anime_detail_page.dart';

class HomePageGridView extends StatelessWidget {
  List<dynamic> state;
  final void Function()? onTap;

  HomePageGridView({super.key, required this.state, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
      ),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: state.length,
      itemBuilder: (context, index) {
        final anime = state[index];
        return InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height,
                    child: Image.network(
                      anime.images?.jpg?.imageUrl ?? "",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.only(left: 10),
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.5,
                      color: Colors.black54,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              anime.title ?? "Animes",
                              style: buildTextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 10,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
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
                            "${anime?.score ?? ""}",
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
              ),
            ),
          ),
        );
      },
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
