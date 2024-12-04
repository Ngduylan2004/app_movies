import 'package:app_movies/core/entities/movies_entities.dart';
import 'package:app_movies/features/detail/presentation/pages/detail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MovieItemLargeWidget extends StatelessWidget {
  final String image;
  final String name;
  final bool isLarge;
  final MoviesEntities movie;

  const MovieItemLargeWidget({
    super.key,
    required this.image,
    required this.name,
    required this.isLarge,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    // In ra giá trị của imageUrl để debug
    String imageUrl =
        'https://media.themoviedb.org/t/p/w220_and_h330_face$image';

    return GestureDetector(
      onTap: () {
        // Điều hướng sang trang chi tiết khi nhấn vào
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(movie: movie),
          ),
        );
      },
      child: SizedBox(
        width: (MediaQuery.of(context).size.width - 60) / 2,
        height: isLarge ? 260 : 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
