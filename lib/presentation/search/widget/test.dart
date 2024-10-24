// import 'package:flutter/material.dart';
// import 'package:movie_app/models/movie_model.dart';
// import 'package:movie_app/presentation/search/widget/movie_group_widget.dart';

// class SearchingScreen extends StatefulWidget {
//   const SearchingScreen({super.key});

//   @override
//   State<SearchingScreen> createState() => _SearchingScreenState();
// }

// class _SearchingScreenState extends State<SearchingScreen> {
//   final TextEditingController _searchController = TextEditingController();
//   int index = 0;
//   final _list = List.generate(
//     12,
//     (index) =>
//         MovieModel(name: 'Ten phim $index', image: 'assets/images/anh1.png'),
//   );

// // Chia danh sách thành các phần con với mỗi phần gồm 4 phần tử
//   List<List<MovieModel>> chunkedList = [];

// // Sử dụng vòng lặp để chia thành các phần con

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 4, // Số lượng tab
//       child: Scaffold(
//         backgroundColor: const Color(0xff15141F),

//         // Đặt màu nền của Scaffold là màu đen
//         appBar: AppBar(
//           toolbarHeight: 100, // giới hạn độ cao appbar
//           backgroundColor:
//               const Color(0xff15141F), // Đặt màu nền của AppBar là màu đen
//           title: const Padding(
//               padding: EdgeInsets.only(top: 10, left: 10),
//               child: Text(
//                 'Find Movies, Tv series,\n and more..',
//                 style: TextStyle(
//                     color: Colors.white, fontFamily: 'MyFont', fontSize: 30),
//               )),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               TextField(
//                 controller: _searchController,

//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: const Color(0xff211F30), // backround input
//                   hintText: 'Sherlock Holmes..',
//                   hintStyle:
//                       TextStyle(color: Colors.grey[400]), // Màu chữ gợi ý
//                   prefixIcon: const Icon(Icons.search,
//                       color: Colors.white), // Màu của biểu tượng tìm kiếm
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(24),
//                     borderSide: const BorderSide(
//                         color: Colors.grey), // Màu viền của TextField
//                   ),
//                 ),
//                 style: const TextStyle(
//                     color: Colors.white), // Màu chữ trong TextField
//               ),
//               const SizedBox(height: 10),
//               TabBar(
//                 onTap: (value) {
//                   setState(() {
//                     index = value;
//                   });
//                 },
//                 isScrollable: true, // gia hạn kích thước
//                 indicatorSize: TabBarIndicatorSize.label,
//                 tabs: const <Widget>[
//                   Tab(text: 'Movies'),
//                   Tab(text: 'TV Series'),
//                   Tab(text: 'Documentary'),
//                   Tab(text: 'Sports'),
//                 ],

//                 indicatorColor: Colors.white, // Màu chỉ báo cho tab
//                 labelColor: Colors.white, // Màu chữ của tab
//                 unselectedLabelColor: Colors
//                     .grey, // Màu chữ của tab không được chọn // Màu chỉ báo cho tab
//               ),
//               const SizedBox(height: 20),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: index,
//                   itemBuilder: (context, index) => const Center(
//                     child: MovieGroupWidget(),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
