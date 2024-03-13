import 'package:flutter/material.dart';
import 'package:flutter_anime_list/data/model/anime_model/anime_data_model.dart';
import 'package:flutter_anime_list/features/pages/home/components/home_page_grid_view.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {});
  testWidgets('Home User List Test', (tester) async {
    final animes = [
      Anime(title: "Sousou no Frieren", score: 9.5),
      Anime(title: "Fullmetal Alchemist", score: 9.5),
      Anime(title: "Brotherhood", score: 9.5),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          appBar: AppBar(),
          body: HomePageGridView(
            state: animes,
            onTap: () {},
          ),
        ),
      ),
    );

    for (final item in animes) {
      expect(find.text(item.title ?? "test title"), findsOneWidget);
    }

    await tester.tap(find.byType(IconButton));
    await tester.pumpAndSettle();

    expect(find.text('Home Detail View'), findsOneWidget);
  });
}
