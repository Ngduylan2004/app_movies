import 'package:app_movies/core/entities/movies_entities.dart';
import 'package:app_movies/features/detail/presentation/pages/detail_page.dart';
import 'package:flutter/material.dart';

class MovieItemLargeWidget extends StatelessWidget {
  final String image;
  final String name;
  final bool isLarge;
  final MoviesEntities movie; // Thêm đối tượng phim

  const MovieItemLargeWidget({
    super.key,
    required this.image,
    required this.name,
    required this.isLarge,
    required this.movie, // Thêm đối tượng phim vào constructor
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Điều hướng sang trang chi tiết khi nhấn vào
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailPage(movie: movie), // Truyền dữ liệu phim
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
                borderRadius: BorderRadius.circular(16.0), // Bo góc
                child: Image.network(
                  'https://media.themoviedb.org/t/p/w220_and_h330_face$image',
                  fit: BoxFit.cover, // Đảm bảo ảnh phủ kín khu vực
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(fontSize: 16, color: Colors.white),
              maxLines: 2, // Giới hạn số dòng của văn bản
              overflow: TextOverflow.ellipsis, // Thêm dấu "..." nếu văn bản dài
              textAlign: TextAlign.center, // Căn giữa văn bản
            ),
          ],
        ),
      ),
    );
  }
}
