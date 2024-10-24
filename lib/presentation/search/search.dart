// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'bloc/search_bloc.dart';

// class Search extends StatelessWidget {
//   final TextEditingController _searchController = TextEditingController();

//   Search({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Tìm kiếm phim')),
//       body: Column(
//         children: [
//           // Ô nhập tìm kiếm
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Nhập tên phim...',
//                 suffixIcon: IconButton(
//                   icon: const Icon(Icons.search),
//                   onPressed: () {
//                     final keyword = _searchController.text.trim();
//                     if (keyword.isNotEmpty) {
//                       context
//                           .read<SearchBloc>()
//                           .add(SearchKeyWord(query: keyword));
//                     }
//                   },
//                 ),
//               ),
//             ),
//           ),
//           // Danh sách phim tìm kiếm
//           Expanded(
//             child: BlocBuilder<SearchBloc, SearchState>(
//               builder: (context, state) {
//                 if (state.movies.isEmpty) {
//                   return const Center(child: Text('Không tìm thấy phim!'));
//                 }

//                 return ListView.builder(
//                   itemCount: state.movies.length,
//                   itemBuilder: (context, index) {
//                     final movie = state.movies[index];
//                     return ListTile(
//                       title: Text(movie.title ?? ''),
//                       subtitle: Text(movie.voteAverage.toString()),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
