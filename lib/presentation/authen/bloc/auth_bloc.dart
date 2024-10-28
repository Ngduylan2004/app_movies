import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthCheckRequested>((event, emit) async {
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
    return token != null; // Trả về true nếu token tồn tại
  }
}
