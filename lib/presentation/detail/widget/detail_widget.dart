import 'dart:math'; // Import thư viện dart:math để sử dụng Random

import 'package:app_movies/presentation/detail/bloc/detail_bloc.dart';
import 'package:app_movies/presentation/detail/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailWidget extends StatelessWidget {
  const DetailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailState>(
      builder: (context, state) {
        // Randomize danh sách relatedMovies
        List relatedMovies = state.relatedMovies.toList();
        relatedMovies.shuffle(Random()); // Trộn ngẫu nhiên danh sách

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: relatedMovies.take(5).map((movie) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(movie: movie),
                    ),
                  );
                },
                child: _buildImageWithLabel(
                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                  movie.title ?? 'Untitled',
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildImageWithLabel(String imagePath, String label) {
    return Container(
      width: 170,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              imagePath,
              width: 170,
              height: 130,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
            maxLines: 1,
            overflow: TextOverflow.visible,
          ),
        ],
      ),
    );
  }
}
