import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class Movie {
  @HiveField(0)
  @JsonKey(name: 'id')
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @HiveField(3)
  final String overview;

  Movie(
      {required this.id,
      required this.title,
      this.posterPath,
      required this.overview});

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
