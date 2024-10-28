import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SignInBloc() : super(const SignInInitial()) {
    on<SignInEvent>((event, emit) async {
      emit(const SignInLoading());

      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.passWord,
        );

        // Lưu token (hoặc UID) sau khi đăng nhập thành công
        await saveToken(userCredential.user!.uid);

        emit(SignInSuccess(userCredential.user!.uid));
      } on FirebaseAuthException catch (error) {
        // In thông báo lỗi
        print('[SignInBloc] - [SignInEvent] err message: ${error.message}');

        emit(SignInFailure(
            error.message ?? 'Đã xảy ra lỗi trong quá trình đăng nhập'));
      } catch (e) {
        emit(SignInFailure('Đã xảy ra lỗi không mong muốn: $e'));
      }
    });
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token); // Lưu token vào SharedPreferences
    final expiryDate = DateTime.now()
        .add(const Duration(seconds: 50))
        .millisecondsSinceEpoch; // Thay đổi từ phút sang giây
    await prefs.setInt('token_expiry', expiryDate); // Lưu thời gian hết hạn
    print("Token saved: $token");
  }
}
