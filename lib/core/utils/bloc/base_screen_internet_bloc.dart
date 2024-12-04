import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'base_screen_internet_event.dart';
part 'base_screen_internet_state.dart';

class BaseScreenInternetBloc
    extends Bloc<BaseScreenInternetEvent, BaseScreenInternetState> {
  final InternetConnectionChecker internetConnectionChecker;
  StreamSubscription? internetSubscription;

  BaseScreenInternetBloc(this.internetConnectionChecker)
      : super(BaseScreenInternetState(
          errorMessage: '',
          isConnected: false,
        )) {
    // Lắng nghe sự thay đổi kết nối mạng
    internetSubscription =
        internetConnectionChecker.onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.connected) {
        // ignore: invalid_use_of_visible_for_testing_member
        emit(BaseScreenInternetState(
          errorMessage: '',
          isConnected: true,
        ));
      } else {
        // ignore: invalid_use_of_visible_for_testing_member
        emit(BaseScreenInternetState(
          errorMessage: 'No internet connection',
          isConnected: false,
        ));
      }
    });
  }

  // Hủy đăng ký khi Bloc đóng
  @override
  Future<void> close() {
    internetSubscription?.cancel(); // Hủy đăng ký khi Bloc đóng
    return super.close(); // Gọi phương thức close của BlocProvider
  }
}
