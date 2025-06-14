import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dio/dio.dart';

import 'core/constants/app_routes.dart';
import 'core/constants/app_theme.dart';
import 'data/local/db_initializer.dart';
import 'data/models/movie.dart';
import 'data/remote/api_service.dart';
import 'data/repository/movie_repository.dart';
import 'presentation/viewmodels/movie_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeLocalDB();

  final box = Hive.box<Movie>('bookmarks');

  final dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 25),
    receiveTimeout: const Duration(seconds: 30),
  ));

  final api = ApiService(dio);
  const apiKey = 'a18bc776bafc2fd6753672c0fc1f7439';
  final repo = MovieRepository(api: api, box: box, apiKey: apiKey);
  final viewModel = MovieViewModel(repo);

  runApp(
    ProviderScope(
      overrides: [
        movieViewModelProvider.overrideWithValue(viewModel),
      ],
      child: const MovieApp(),
    ),
  );
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Movie App',
      routerConfig: routes,
      theme: AppTheme.light,
    );
  }
}
