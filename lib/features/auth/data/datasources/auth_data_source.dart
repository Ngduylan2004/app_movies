import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthDataSource {
  Future<void> signInWithGoogle();
  Future<void> signInWithUsernamePassword(
      final String email, final String password);

  Future<void> signOut();

  Future<void> signUpWithUsernamePassword(
    final String email,
    final String password,
    final String displayName,
  );
}

class AuthDataSourceImpl implements AuthDataSource {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  //đăng nhập với google
  @override
  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential userCredential =
        await auth.signInWithCredential(credential);
    return userCredential.user!.uid;
  }

//đăng nhập với email và password
  @override
  Future<void> signInWithUsernamePassword(String email, String password) async {
    await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

//đăng xuất
  @override
  Future<void> signOut() async {
    await auth.signOut();
    await googleSignIn.signOut();
  }

  //đăng kí
  @override
  Future<void> signUpWithUsernamePassword(
      String email, String password, String displayName) async {
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // Lưu thông tin người dùng vào Firestore
    await firestore
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({'email': email, 'displayName': displayName});
  }
}
