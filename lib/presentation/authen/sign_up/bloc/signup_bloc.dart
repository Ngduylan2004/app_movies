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
            .collection('user')
            .doc(userCredential.user!.uid)
            .set({'email': event.email, 'username': event.username});

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
    // on<SignupEventGoogle>((event, emit) async {
    //   emit(SignupLoading());

    //   try {
    //     // Bắt đầu quá trình đăng nhập Google
    //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    //     // Kiểm tra xem người dùng có hủy quá trình đăng nhập không
    //     if (googleUser == null) {
    //       emit(SignupFailure("Đăng nhập bị hủy"));
    //       return; // Nếu người dùng hủy
    //     }

    //     // Lấy thông tin xác thực
    //     final GoogleSignInAuthentication googleAuth =
    //         await googleUser.authentication;

    //     // Tạo chứng thực Firebase từ thông tin Google
    //     final AuthCredential credential = GoogleAuthProvider.credential(
    //       accessToken: googleAuth.accessToken,
    //       idToken: googleAuth.idToken,
    //     );

    //     // Thực hiện đăng nhập hoặc đăng ký
    //     final UserCredential userCredential =
    //         await _auth.signInWithCredential(credential);

    //     // Kiểm tra xem người dùng có tồn tại không
    //     if (userCredential.additionalUserInfo?.isNewUser == true) {
    //       // Nếu là người dùng mới, lưu thông tin vào Firestore
    //       await _firestore
    //           .collection('user')
    //           .doc(userCredential.user!.uid)
    //           .set({
    //         'email': googleUser.email,
    //         'username': googleUser.displayName ?? 'Người dùng mới',
    //       });

    //       emit(SignupSuccess()); // Phát ra trạng thái thành công
    //     } else {
    //       emit(SignupFailure(
    //           "Tài khoản Google đã tồn tại. Vui lòng đăng nhập.")); // Tài khoản đã tồn tại
    //     }
    //   } on FirebaseAuthException catch (error) {
    //     emit(SignupFailure(
    //         error.message ?? 'Lỗi trong quá trình đăng ký với Google'));
    //   } catch (e) {
    //     emit(SignupFailure('Lỗi không mong muốn: $e'));
    //   }
    // });
  }
}
