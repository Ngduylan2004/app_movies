// data/models/genre_movies_model.dart

import 'package:app_movies/core/entities/genre_movies_entities.dart';

class GenreMoviesModel extends GenreMoviesEntities {
  @override
  final int id;
  @override
  final String name;

  GenreMoviesModel({
    required this.id,
    required this.name,
  }) : super(id: id, name: name);

  // Phương thức từ JSON sang GenreMoviesModel
  factory GenreMoviesModel.fromJson(Map<String, dynamic> json) {
    return GenreMoviesModel(
      id: json['id'],
      name: json['name'],
    );
  }

  // Phương thức chuyển từ GenreMoviesModel sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
