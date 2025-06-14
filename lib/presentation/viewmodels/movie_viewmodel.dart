import 'package:flutter_movie_app/data/models/movie_response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repository/movie_repository.dart';
import '../../data/models/movie.dart';

final movieViewModelProvider = Provider<MovieViewModel>((ref) {
  throw UnimplementedError();
});

class MovieViewModel {
  final MovieRepository repo;

  MovieViewModel(this.repo);

  Future<Movie> fetchMovieById(String id) => repo.getMovieById(id);

  Future<List<Movie>> fetchTrending() => repo.getTrendingMovies();
  Future<List<Movie>> fetchNowPlaying() => repo.getNowPlayingMovies();
  Future<List<Movie>> search(String query) => repo.search(query);
  List<Movie> getBookmarks() => repo.getSavedMovies();
  void bookmark(Movie movie) => repo.bookmarkMovie(movie);
  void unbookmark(int id) => repo.removeBookmark(id);
  bool isBookmarked(int id) => repo.isBookmarked(id);
}
