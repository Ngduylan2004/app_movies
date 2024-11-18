import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  SignupBloc() : super(SignupState()) {
    on<SignEventOne>((event, emit) async {
      emit(SignupLoading());

      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.pass,
        );

        // Lưu thông tin người dùng vào Firestore
        await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({'email': event.email, 'displayName': event.displayName});

        // Phát ra trạng thái thành công
        emit(SignupSuccess());
      } on FirebaseAuthException catch (error) {
        // In ra thông báo lỗi
        print('[SignupBloc] - [SignupEvent] error message: ${error.message}');
        emit(
            SignupFailure(error.message ?? 'An error occurred during sign-up'));
      } catch (e) {
        emit(SignupFailure('An unexpected error occurred: $e'));
      }
    });
  }
}
