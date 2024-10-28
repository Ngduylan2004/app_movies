import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthCheckRequested>((event, emit) async {
      await Future.delayed(const Duration(seconds: 5));
      final isAuth = await checkToken();
      if (isAuth) {
        emit(AuthLogin());
      } else {
        emit(AuthNoLogin());
      }
    });
  }

  Future<bool> checkToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token'); // Kiểm tra token
    print('Token retrieved: $token'); // In ra token
    final expiryDate = prefs.getInt('token_expiry'); // Lấy thời gian hết hạn
    print('Token expiry date: $expiryDate'); // In ra thời gian hết hạn

    if (token != null && expiryDate != null) {
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      if (currentTime < expiryDate) {
        return true; // Token còn hiệu lực
      } else {
        // Xóa token vì đã hết hạn
        await prefs.remove('token');
        await prefs.remove('token_expiry');
      }
    }
    return false; // Token không tồn tại hoặc đã hết hạn
  }
}
