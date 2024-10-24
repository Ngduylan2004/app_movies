import 'package:app_movies/presentation/detail/detail_screen.dart';
import 'package:app_movies/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/search_bloc.dart';

class SearchDetailScreen extends StatelessWidget {
  final TextEditingController _searchControllers = TextEditingController();
  final String searchQuery;

  SearchDetailScreen({super.key, required this.searchQuery}) {
    _searchControllers.text =
        searchQuery; // Gán giá trị khởi tạo từ searchQuery
  }

  @override
  Widget build(BuildContext context) {
    // Khởi tạo tìm kiếm ngay khi chuyển vào trang bằng cách gửi sự kiện SearchKeyWord
    //note
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SearchBloc>().add(SearchKeyWord(query: searchQuery));
    });

    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            const Spacer(),
            const Text(
              'Search',
              style: TextStyle(color: Colors.white),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.warning, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              // Search bar
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      autofocus: false,
                      controller: _searchControllers,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xff211F30),
                        hintText: 'Sherlock Holmes..',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.search, color: Colors.white),
                          onPressed: () {
                            final keyWord = _searchControllers.text.trim();
                            if (keyWord.isNotEmpty) {
                              context
                                  .read<SearchBloc>()
                                  .add(SearchKeyWord(query: keyWord));
                            }
                          },
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            context
                                .read<SearchBloc>()
                                .add(SearchKeyWord(query: ''));
                            // Gửi sự kiện tìm kiếm với từ khóa rỗng
                            _searchControllers.clear();
                          },
                          icon: const Icon(Icons.clear, color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              // Display list of movies
              Expanded(
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state.movies.isEmpty) {
                      // Nếu không có phim nào được tìm thấy, hiển thị thông báo
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.cloud_off, color: Colors.grey, size: 80),
                            SizedBox(height: 16),
                            Text(
                              'We are sorry, we can \n not find the movie :(',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Find your movie by typing title,\n categories, years, etc.',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: state.movies.length,
                      itemBuilder: (context, index) {
                        final movie = state.movies[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailPage(movie: movie)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      movie.posterPath != null
                                          ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                                          : 'https://via.placeholder.com/150',
                                      width:
                                          (MediaQuery.of(context).size.width -
                                                  210) /
                                              2,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movie.title!,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(Icons.star,
                                              color: Colors.amber, size: 18),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${movie.voteAverage}',
                                            style: const TextStyle(
                                                color: Colors.amber),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.thumb_up,
                                              color: Colors.white, size: 18),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${movie.voteCount}',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.calendar_today,
                                              color: Colors.white, size: 18),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${movie.releaseDate}',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
