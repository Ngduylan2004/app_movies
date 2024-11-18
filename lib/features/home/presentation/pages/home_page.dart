import 'package:app_movies/features/home/presentation/bloc/home_bloc.dart';
import 'package:app_movies/features/newFeed/presentation/pages/newfeed_page.dart';
import 'package:app_movies/features/search/presentation/pages/searching_page.dart';
import 'package:app_movies/features/user/presentation/pages/acount_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Ví dụ tạo widget màn hình Home

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Tạo danh sách màn hình

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Hiển thị màn hình theo index đã chọn
          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state.pageIndex == 0) {
                  return const NewfeedPage();
                } else if (state.pageIndex == 1) {
                  return const SearchingPage();
                } else if (state.pageIndex == 2) {
                  return const AcountPage();
                }
                return Container();
              },
            ),
          ),
          // Thanh dưới cùng chứa các biểu tượng (icon)
          Container(
            color: Colors.black, // Đặt màu nền cho thanh dưới
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.home, color: Colors.white, size: 35),
                  onPressed: () => _onIconTapped(0), // Chuyển về màn hình Home
                ),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.white, size: 35),
                  onPressed: () =>
                      _onIconTapped(1), // Chuyển về màn hình tìm kiếm
                ),
                IconButton(
                  icon: const Icon(Icons.person, color: Colors.white, size: 35),
                  onPressed: () =>
                      _onIconTapped(2), // Chuyển về màn hình tìm kiếm
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onIconTapped(int index) {
    context.read<HomeBloc>().add(
          NavigatorPage(index),
        );
  }
}
