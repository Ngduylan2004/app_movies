import 'package:app_movies/core/utils/bloc/base_screen_internet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseScreen extends StatefulWidget {
  final Widget child;
  const BaseScreen({super.key, required this.child});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  bool _isDialogShowing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<BaseScreenInternetBloc, BaseScreenInternetState>(
        listener: (context, state) {
          // Kiểm tra kết nối internet và hiển thị hoặc ẩn dialog lỗi
          if (!state.isConnected && !_isDialogShowing) {
            _showErrorDialog(context, state.errorMessage);
          } else if (state.isConnected && _isDialogShowing) {
            _dismissErrorDialog(context);
          }
        },
        child: widget.child,
      ),
    );
  }

  // Hàm để ẩn dialog lỗi khi kết nối lại internet
  void _dismissErrorDialog(BuildContext context) {
    _isDialogShowing = false;
    Navigator.of(context, rootNavigator: true).pop();
  }

  // Hàm để hiển thị dialog lỗi
  void _showErrorDialog(BuildContext context, String errorMessage) {
    _isDialogShowing = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Lỗi Kết Nối'),
          content: Text(errorMessage),
        );
      },
    );
  }
}
