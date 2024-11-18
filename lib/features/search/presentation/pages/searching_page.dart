import 'package:app_movies/core/entities/movies_entities.dart';
import 'package:app_movies/features/search/data/repositories/search_repository_impl.dart';
import 'package:app_movies/features/search/presentation/bloc/search_bloc.dart';
import 'package:app_movies/features/search/presentation/pages/search_detail_page.dart';
import 'package:app_movies/features/search/presentation/widgets/movie_group_widget.dart';
import 'package:app_movies/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchingPage extends StatefulWidget {
  const SearchingPage({super.key});

  @override
  State<SearchingPage> createState() => _SearchingPageState();
}

class _SearchingPageState extends State<SearchingPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(SearchRepositoryImpl.instance)
        ..add(SearchEventLoadMovies())
        ..add(SearchEventGenreMovies()),
      child: Scaffold(
        backgroundColor: AppTheme.primaryColor,
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0, // đổi nổi của appBar khi cuộn
          title: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Text(
              AppLocalizations.of(context)!.searchTitle,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Lato',
                fontSize: 23,
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
                          hintText:
                              AppLocalizations.of(context)!.searchTextField,
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
                                    builder: (context) => SearchDetailPage(
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
