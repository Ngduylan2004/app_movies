import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

        emit(SignInSuccess(userCredential.user!.uid));
      } on FirebaseAuthException catch (error) {
        // Print specific error code and message

        print('[SignInBloc] - [SignInEvent] err message: ${error.message}');

        emit(
            SignInFailure(error.message ?? 'An error occurred during sign-in'));
      } catch (e) {
        emit(SignInFailure('An unexpected error occurred: $e'));
      }
    });
  }
}
