import 'package:flutter_movie_app/data/models/movie_response.dart';
import 'package:hive/hive.dart';
import '../models/movie.dart';
import '../remote/api_service.dart';

class MovieRepository {
  final ApiService api;
  final Box<Movie> box;
  final String apiKey;

  MovieRepository({required this.api, required this.box, required this.apiKey});

  Future<List<Movie>> getTrendingMovies() async {
    final response = await api.getTrending(apiKey);
    await box.putAll({for (var movie in response.results) movie.id: movie});
    return response.results;
  }

  Future<Movie> getMovieById(String id) async {
    return await api.getMovieDetails(id, apiKey);
  }

  Future<List<Movie>> getNowPlayingMovies() async {
    final response = await api.getNowPlaying(apiKey);
    await box.putAll({for (var movie in response.results) movie.id: movie});
    return response.results;
  }

  Future<List<Movie>> search(String query) async {
    final response = await api.searchMovies(apiKey, query);
    return response.results;
  }

  List<Movie> getSavedMovies() => box.values.toList();
  void bookmarkMovie(Movie movie) => box.put(movie.id, movie);
  void removeBookmark(int id) => box.delete(id);
  bool isBookmarked(int id) => box.containsKey(id);
}
