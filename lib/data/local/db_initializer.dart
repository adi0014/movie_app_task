import 'package:hive_flutter/hive_flutter.dart';
import '../models/movie.dart';

Future<void> initializeLocalDB() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MovieAdapter());
  await Hive.openBox<Movie>('bookmarks');
}
