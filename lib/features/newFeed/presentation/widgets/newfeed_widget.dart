import 'package:app_movies/features/detail/presentation/pages/detail_page.dart';
import 'package:app_movies/features/newFeed/presentation/bloc/newfeed_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewfeedWidget extends StatelessWidget {
  const NewfeedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewfeedBloc, NewfeedState>(
      builder: (context, state) {
        if (state.trendingMovies.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return SizedBox(
          height: 400,
          child: CarouselSlider(
            options: CarouselOptions(
              height: 400.0,
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              viewportFraction:
                  0.85, // Tăng viewportFraction để hình ảnh có không gian
            ),
            items: state.trendingMovies.map((movie) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(movie: movie), // Truyền dữ liệu phim
                        ),
                      );
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                              width: MediaQuery.of(context).size.width * 0.75,
                              height: 400,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Positioned(
                        //   bottom: 10,
                        //   child: Container(
                        //     width: 160, // Tăng kích thước để đẹp hơn
                        //     height: 60,
                        //     decoration: BoxDecoration(
                        //       color: Colors.grey.withOpacity(
                        //           0.6), // Đổi màu cho độ tương phản
                        //       borderRadius: BorderRadius.circular(20),
                        //     ),
                        //     child: Center(
                        //       child: Text(
                        //         movie.title ?? 'Unknown Title',
                        //         style: const TextStyle(
                        //           fontSize: 14,
                        //           fontWeight: FontWeight
                        //               .bold, // Thêm độ đậm cho tiêu đề
                        //           color: Colors.white,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // Thêm phần đánh giá ở góc trên bên phải
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(
                                  0.7), // Thay đổi màu sắc cho hấp dẫn hơn
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 18, // Tăng kích thước biểu tượng
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  movie.voteAverage?.toStringAsFixed(1) ??
                                      'N/A',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16, // Tăng kích thước chữ
                                    fontWeight: FontWeight
                                        .bold, // Thêm độ đậm cho đánh giá
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Thêm các widget khác nếu cần
                      ],
                    ),
                  );
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
