// lấy api trên header cho bảo mật
// import 'package:app_movies/data/repostory/movies_repostory_impl.dart';
// import 'package:app_movies/presentation/newFeed/bloc/new_feed_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class NewfeedBannerWidget extends StatefulWidget {
//   const NewfeedBannerWidget({super.key});

//   @override
//   _NewfeedBannerWidgetState createState() => _NewfeedBannerWidgetState();
// }

// class _NewfeedBannerWidgetState extends State<NewfeedBannerWidget> {
//   late YoutubePlayerController _controller;

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) =>
//           NewFeedBloc(MoviesRepositoryImpl.instance)..add(NewFeedEventVideo()),
//       child: BlocBuilder<NewFeedBloc, NewFeedState>(
//         builder: (context, state) {
//           // Khởi tạo controller với video mẫu nếu chưa được khởi tạo
//           if (state.videoTrending.isNotEmpty) {
//             _controller = YoutubePlayerController(
//               initialVideoId: state.videoTrending[0].key ?? '',
//               flags: const YoutubePlayerFlags(
//                 mute: false,
//                 autoPlay: true,
//               ),
//             );
//           }

//           if (state.videoTrending.isEmpty) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           // Cập nhật videoId khi có videoTrending
//           if (_controller.initialVideoId != state.videoTrending[0].key) {
//             _controller.dispose(); // Giải phóng controller cũ
//             _controller = YoutubePlayerController(
//               initialVideoId: state.videoTrending[0].key ?? '',
//               flags: const YoutubePlayerFlags(
//                 mute: false,
//                 autoPlay: true,
//               ),
//             );
//           }

//           return Column(
//             children: [
//               SizedBox(
//                 width: double.infinity,
//                 height: 200, // Chiều cao video
//                 child: YoutubePlayer(
//                   controller: _controller,
//                   showVideoProgressIndicator: true,
//                   progressIndicatorColor: Colors.amber,
//                   progressColors: const ProgressBarColors(
//                     playedColor: Colors.amber,
//                     handleColor: Colors.amberAccent,
//                   ),
//                   aspectRatio: 16 / 9, // Tùy chỉnh tỷ lệ video
//                   onReady: () {
//                     _controller.addListener(() {
//                       // Bổ sung nếu cần thiết
//                     });
//                   },
//                 ),
//               ),
//               // Hiển thị tên video bên dưới
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   state.videoTrending[0].key ??
//                       'Tên video không có', // Hiển thị tên video
//                   style: const TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                   textAlign: TextAlign.center, // Căn giữa
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose(); // Giải phóng controller khi widget bị hủy
//     super.dispose();
//   }
// }
