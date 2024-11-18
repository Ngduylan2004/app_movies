import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // final FirebaseStorage _storage = FirebaseStorage.instance;
  final storageRef = FirebaseStorage.instance.ref();

  UserBloc() : super(UserInitial()) {
    // Tạo mới người dùng
    on<CreatUserEvent>((event, emit) async {
      await _firestore.collection('user').doc(_auth.currentUser?.uid).set({
        'firstName': event.firstName,
        'lastName': event.lastName,
        'dob': event.dob,
        'gender': event.gender,
      });
      emit(UserSuccess());
    });

    // Lấy thông tin người dùng từ tk google
    on<GetUserEvent>((event, emit) async {
      emit(UserLoading());
      try {
        User? currentUser = _auth.currentUser;
        if (currentUser != null) {
          DocumentSnapshot userData =
              await _firestore.collection('user').doc(currentUser.uid).get();

          String email = '';
          if (currentUser.email != null && currentUser.email!.isNotEmpty) {
            email = currentUser.email!;
          } else {
            // Thử lấy email từ providerData nếu đăng nhập bằng Google
            for (var userInfo in currentUser.providerData) {
              if (userInfo.email != null && userInfo.email!.isNotEmpty) {
                email = userInfo.email!;
                break;
              }
            }
          }

          String firstName = userData['firstName'] ?? '';
          String lastName = userData['lastName'] ?? '';
          String dob = userData['dob'] ?? '';
          String gender = userData['gender'] ?? '';

          emit(UserGetState(
              email: email,
              firstName: firstName,
              lastName: lastName,
              dob: dob,
              gender: gender));
        }
      } catch (e) {}
    });
    // Cập nhật thông tin người dùng
    on<UpdateUserEvent>((event, emit) async {
      emit(UserLoading());
      try {
        await _firestore.collection('user').doc(_auth.currentUser?.uid).update({
          'firstName': event.firstName,
          'lastName': event.lastName,
          'dob': event.dob,
          'gender': event.gender,
        });

        User? currentUser = _auth.currentUser;
        if (currentUser != null) {
          DocumentSnapshot userData =
              await _firestore.collection('user').doc(currentUser.uid).get();

          String firstName = userData['firstName'] ?? '';
          String lastName = userData['lastName'] ?? '';
          String dob = userData['dob'] ?? '';
          String gender = userData['gender'] ?? '';

          emit(UpdateUserState(
              firstName: firstName,
              lastName: lastName,
              dob: dob,
              gender: gender,
              imageUrl: event.imageUrl));
        }
      } catch (e) {
        emit(UserInitial());
      }
    });
    // getImage

    on<ImageUserEvent>((event, emit) async {
      //khỏi tạo lấy ảnh
      String? imageUrl = '';
      final ByteData imageData =
          await rootBundle.load('assets/images/anh1.png');
      Uint8List bytes = imageData.buffer.asUint8List();
      final Reference storageRef =
          FirebaseStorage.instance.ref().child('assets/images/anh1.png');
      await storageRef.putData(bytes);
      emit(ImageUserState(imageUrl: imageUrl));
    });
  }
}
