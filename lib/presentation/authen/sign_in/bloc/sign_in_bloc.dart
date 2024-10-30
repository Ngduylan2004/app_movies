import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SignInBloc() : super(const SignInInitial()) {
    on<SignCheckEvent>((event, emit) async {
      emit(const SignInLoading());

      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.passWord,
        );
        // final user = FirebaseAuth.instance.authStateChanges;

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
    on<SignOutEvent>(
      (event, emit) async {
        try {
          await _auth.signOut();
          emit(SignoutSuccess());
        } catch (e) {
          emit(SignInFailure(
              'An unexpected error occurred while signing out: $e'));
        }
      },
    );
  }
}
