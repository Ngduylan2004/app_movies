import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SignupBloc() : super(SignupInitial()) {
    on<SignupEvent>((event, emit) async {
      emit(SignupLoading()); // Phát ra trạng thái đang tải

      try {
        // Tạo người dùng mới với email và password
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.pass,
        );

        // Lưu thông tin người dùng vào Firestore
        await _firestore.collection('user').doc(userCredential.user!.uid).set({
          'email': event.email,
        });

        emit(SignupSuccess());
      } catch (e) {
        emit(SignupFailure());
      }
    });
  }
}
