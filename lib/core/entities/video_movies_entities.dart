import 'package:app_movies/core/model/video_movies.dart';

class VideoMoviesEntities {
  String? iso6391;
  String? iso31661;
  String? name;
  String? key;
  String? site;
  int? size;
  String? type;
  bool? official;
  String? publishedAt;
  String? id;

  VideoMoviesEntities(
      {this.iso6391,
      this.iso31661,
      this.name,
      this.key,
      this.site,
      this.size,
      this.type,
      this.official,
      this.publishedAt,
      this.id});

  @override
  String toString() {
    return ('key movie: $key');
  }

  static fromJson(VideoMovies video) {}
}
