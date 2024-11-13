import 'package:app_movies/presentation/newFeed/bloc/new_feed_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class NewfeedBannerWidget extends StatefulWidget {
  const NewfeedBannerWidget({super.key});

  @override
  _NewfeedBannerWidgetState createState() => _NewfeedBannerWidgetState();
}

class _NewfeedBannerWidgetState extends State<NewfeedBannerWidget> {
  late YoutubePlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewFeedBloc, NewFeedState>(
      builder: (context, state) {
        if (state.videoTrending.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final videoId = state.videoTrending[0].key ?? '';
        final thumbnailUrl =
            'https://img.youtube.com/vi/$videoId/maxresdefault.jpg'; // Lấy ảnh thumbnail từ video

        return GestureDetector(
          onTap: () {
            _showVideoDialog(context, videoId);
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 200,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(thumbnailUrl), // Hiển thị ảnh thumbnail
                    fit: BoxFit.cover,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.play_circle,
                    size: 50,
                    color: Colors.amber,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Giải phóng controller khi widget bị hủy
    super.dispose();
  }

  // Hàm mở dialog chứa video
  void _showVideoDialog(BuildContext context, String videoId) {
    // Khởi tạo controller cho video
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
          mute: true, autoPlay: false, controlsVisibleAtStart: true),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor:
              const Color.fromARGB(255, 38, 36, 36), // Màu nền của dialog

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25), // Bo góc cho dialog
          ),
          insetPadding: const EdgeInsets.all(20), // Đệm xung quanh dialog
          child: SizedBox(
            width: 400, // Kích thước chiều rộng của dialog
            height: 300, // Kích thước chiều cao của dialog
            child: Column(
              mainAxisSize: MainAxisSize.min, // Chiều cao tự động theo nội dung
              children: [
                // Tiêu đề video
                const Padding(
                  padding: EdgeInsets.all(8.0),
                ),
                // Video player
                Expanded(
                  child: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.red,
                    progressColors: const ProgressBarColors(
                      playedColor: Colors.amber,
                      handleColor: Colors.amberAccent,
                    ),
                    onReady: () {
                      // Thực hiện hành động khi player sẵn sàng
                    },
                  ),
                ),
                // Nút đóng dialog
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      _controller.dispose();
                      Navigator.of(context).pop(); // Đóng dialog
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.newFeedBannerClose,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
