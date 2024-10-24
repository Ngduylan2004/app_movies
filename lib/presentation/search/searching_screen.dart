import 'package:app_movies/data/repostory/movies_repostory_impl.dart';
import 'package:app_movies/domain/entities/movies_entities.dart';
import 'package:app_movies/presentation/search/bloc/search_bloc.dart';
import 'package:app_movies/presentation/search/searchDetail.dart';
import 'package:app_movies/presentation/search/widget/movie_group_widget.dart';
import 'package:app_movies/presentation/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchingScreen extends StatefulWidget {
  const SearchingScreen({super.key});

  @override
  State<SearchingScreen> createState() => _SearchingScreenState();
}

class _SearchingScreenState extends State<SearchingScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(MoviesRepositoryImpl.instance)
        ..add(SearchEventLoadMovies())
        ..add(SearchEventGenreMovies()),
      child: Scaffold(
        backgroundColor: AppTheme.primaryColor,
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.transparent,
          title: const Padding(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Text(
              'Find Movies, TV series,\n and more..',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Lato',
                fontSize: 30,
              ),
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Ô tìm kiếm với nút nhấn
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              onPressed: () {
                                _searchController.clear();
                              },
                              icon: const Icon(Icons.clear)),
                          filled: true,
                          fillColor: const Color(0xff211F30),
                          hintText: 'Sherlock Holmes..',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          prefixIcon: IconButton(
                            icon: const Icon(Icons.search, color: Colors.white),
                            onPressed: () {
                              // Gửi sự kiện tìm kiếm khi người dùng nhấn nút
                              // context.read<SearchBloc>().add(SearchKeyWordMovies(
                              //     keyWord: _searchController.text));
                              // FocusScope.of(context).unfocus();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchDetailScreen(
                                        searchQuery: _searchController.text),
                                  ));
                            },
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
                const SizedBox(height: 10),

                // TabBar cho thể loại phim
                BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state.categories.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return DefaultTabController(
                      length: state.categories.length,
                      child: TabBar(
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.label,
                        onTap: (index) {
                          final selectedGenre = state.categories[index];
                          context
                              .read<SearchBloc>()
                              .add(SearchEventGenreMoviesTab(selectedGenre));
                        },
                        tabs: state.categories
                            .map((category) => Tab(text: category.name))
                            .toList(),
                        indicatorColor: const Color.fromARGB(255, 254, 123, 0),
                        labelColor: AppTheme.accentColor,
                        unselectedLabelColor: Colors.white,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                // Danh sách phim
                Expanded(
                  child: BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      final List<List<MoviesEntities>> chunkedList = [];
                      for (var i = 0; i < state.movies.length; i += 4) {
                        chunkedList.add(state.movies.sublist(
                            i,
                            i + 4 > state.movies.length
                                ? state.movies.length
                                : i + 4));
                      }

                      return ListView.builder(
                        itemCount: chunkedList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child:
                                MovieGroupWidget(listMovie: chunkedList[index]),
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
      ),
    );
  }
}
