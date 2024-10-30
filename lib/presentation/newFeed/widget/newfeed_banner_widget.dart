import 'package:app_movies/presentation/newFeed/bloc/new_feed_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NewfeedBannerWidget extends StatelessWidget {
  const NewfeedBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final YoutubePlayerController controllerVideo;
    return BlocBuilder<NewFeedBloc, NewFeedState>(
      builder: (context, state) {
        if (state.videoTrending.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        YoutubePlayerController controller = YoutubePlayerController(
            initialVideoId: state.videoTrending[1].key ?? '',
            flags: const YoutubePlayerFlags(
                mute: false, autoPlay: false, controlsVisibleAtStart: true));

        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(36),
              //thay bằng video
              child: YoutubePlayer(
                controller: controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.red,
                progressColors: const ProgressBarColors(
                  playedColor: Colors.amber,
                  handleColor: Colors.amberAccent,
                ),
                onReady: () {
                  controller.addListener(() {});
                },
              ),
            ),
            // Positioned(
            //   left: 10,
            //   bottom: 10,
            //   child: Stack(
            //     children: [
            //       Container(
            //         width: 250,
            //         height: 75,
            //         decoration: BoxDecoration(
            //           color: Colors.grey.withOpacity(0.5),
            //           borderRadius: BorderRadius.circular(20),
            //         ),
            //       ),
            //       Positioned(
            //         left: 20,
            //         top: 10,
            //         child: Row(
            //           children: [
            //             Image.asset(
            //               'assets/images/home/icon/Icon.png',
            //               width: 53,
            //               height: 53,
            //             ),
            //             const Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                   'Continue Watching',
            //                   style: TextStyle(
            //                     fontSize: 15,
            //                     color: Color(0xffBCBCBC),
            //                   ),
            //                 ),
            //                 Text(
            //                   'Ready Player One',
            //                   style: TextStyle(
            //                     fontSize: 20,
            //                     color: Colors.white,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        );
      },
    );
  }
}

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
//     return BlocBuilder<NewFeedBloc, NewFeedState>(
//       builder: (context, state) {
//         // Khởi tạo controller với video mẫu nếu chưa được khởi tạo
//         if (state.videoTrending.isNotEmpty) {
//           _controller = YoutubePlayerController(
//             initialVideoId: state.videoTrending[7].key ?? '',
//             flags: const YoutubePlayerFlags(
//               mute: false,
//               autoPlay: true,
//             ),
//           );
//         }

//         if (state.videoTrending.isEmpty) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }

//         // Cập nhật videoId khi có videoTrending
//         if (_controller.initialVideoId != state.videoTrending[0].key) {
//           _controller.dispose(); // Giải phóng controller cũ
//           _controller = YoutubePlayerController(
//             initialVideoId: state.videoTrending[2].key ?? '',
//             flags: const YoutubePlayerFlags(
//                 mute: false, autoPlay: false, controlsVisibleAtStart: true

//                 //behover:bo cong
//                 ),
//           );
//         }

//         return Column(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(30),
//               child: SizedBox(
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
//                   aspectRatio: 32 / 9, // Tùy chỉnh tỷ lệ video
//                   onReady: () {
//                     _controller.addListener(() {
//                       // Bổ sung nếu cần thiết
//                     });
//                   },
//                 ),
//               ),
//             ),
//             // Hiển thị tên video bên dưới
//             // Padding(
//             //   padding: const EdgeInsets.all(8.0),
//             //   child: Text(
//             //     state.videoTrending[0].name ??
//             //         'Tên video không có', // Hiển thị tên video
//             //     style: const TextStyle(
//             //       fontSize: 20,
//             //       fontWeight: FontWeight.bold,
//             //       color: Colors.white,
//             //     ),
//             //     textAlign: TextAlign.center, // Căn giữa
//             //   ),
//             // ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose(); // Giải phóng controller khi widget bị hủy
//     super.dispose();
//   }
// }
