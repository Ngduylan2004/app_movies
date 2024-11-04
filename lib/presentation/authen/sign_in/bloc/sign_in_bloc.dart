import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  SignInBloc() : super(const SignInInitial()) {
    on<SignCheckEvent>((event, emit) async {
      emit(const SignInLoading());

      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.passWord,
        );
        emit(SignInSuccess(userCredential.user!.uid));
      } on FirebaseAuthException catch (error) {
        emit(SignInFailure(
            error.message ?? 'Đã xảy ra lỗi trong quá trình đăng nhập'));
      } catch (e) {
        emit(SignInFailure('Đã xảy ra lỗi không mong muốn: $e'));
      }
    });
    on<SignWithGoogle>((event, emit) async {
      try {
        // Bắt đầu quá trình đăng nhập Google
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        // Lấy thông tin xác thực
        final GoogleSignInAuthentication googleAuth =
            await googleUser!.authentication;
        // Tạo chứng thực Firebase từ thông tin Google
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        // Thực hiện đăng nhập
        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        emit(SignInSuccess(userCredential.user!.uid));
      } on FirebaseAuthException catch (error) {
        emit(SignInFailure(
            error.message ?? 'Lỗi trong quá trình đăng nhập với Google'));
      } catch (e) {
        emit(SignInFailure('Lỗi không mong muốn: $e'));
      }
    });
    on<SignOutEvent>(
      (event, emit) async {
        try {
          await _auth.signOut();
          await _googleSignIn.signOut();
          emit(SignoutSuccess());
        } catch (e) {
          emit(SignInFailure(
              'An unexpected error occurred while signing out: $e'));
        }
      },
    );
  }
}
