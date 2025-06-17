import 'package:flutter_movie_app/data/models/movie.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/movie_response.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://api.themoviedb.org/3/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("movie/{id}")
  Future<Movie> getMovieDetails(
    @Path("id") String id,
    @Query("api_key") String apiKey,
  );

  @GET("trending/movie/day")
  Future<MovieResponse> getTrending(@Query("api_key") String apiKey);

  @GET("movie/now_playing")
  Future<MovieResponse> getNowPlaying(@Query("api_key") String apiKey);

  @GET("search/movie")
  Future<MovieResponse> searchMovies(
      @Query("api_key") String apiKey, @Query("query") String query);
}
