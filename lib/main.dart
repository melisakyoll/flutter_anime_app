import 'package:flutter/material.dart';
import 'package:flutter_anime_list/domain/services/api_services.dart';
import 'package:flutter_anime_list/features/pages/home/anime_list_pages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/anime_bloc_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final ApiServices apiServices = ApiServices();

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<AnimeCubit>(
        create: (context) => AnimeCubit(apiServices),
        child: AnimeListPage(),
      ),
    );
  }
}
