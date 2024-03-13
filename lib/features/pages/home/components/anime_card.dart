import 'package:flutter/material.dart';


class AnimeBannerCard extends StatelessWidget {
  AnimeBannerCard({
    super.key,
    required this.src,

    required this.title,
  });

  String src;

  String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: AspectRatio(
                aspectRatio: 16 / 10,
                child: Image.network(
                  src ?? "",
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                height: 30,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent.withOpacity(0.3),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                       title ?? "",
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
