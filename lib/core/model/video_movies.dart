import 'package:app_movies/core/entities/video_movies_entities.dart';

class VideoMovies extends VideoMoviesEntities {
  VideoMovies({
    super.iso6391,
    super.iso31661,
    super.name,
    super.key,
    super.site,
    super.size,
    super.type,
    super.official,
    super.publishedAt,
    super.id,
  });

  // Phương thức từ JSON
  factory VideoMovies.fromJson(Map<String, dynamic> json) {
    return VideoMovies(
      id: json['id'] as String?,
      iso31661: json['iso_3166_1'] as String?,
      iso6391: json['iso_639_1'] as String?,
      key: json['key'] as String?,
      name: json['name'] as String?,
      official: json['official'] as bool?,
      publishedAt: json['published_at'] as String?,
      site: json['site'] as String?,
      size: json['size'] as int?,
      type: json['type'] as String?,
    );
  }

  // Phương thức chuyển đổi về JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'iso_3166_1': iso31661,
      'iso_639_1': iso6391,
      'key': key,
      'name': name,
      'official': official,
      'published_at': publishedAt,
      'site': site,
      'size': size,
      'type': type,
    };
  }
}
