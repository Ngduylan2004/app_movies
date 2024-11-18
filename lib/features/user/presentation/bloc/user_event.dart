part of 'user_bloc.dart';

class CreatUserEvent extends UserEvent {
  final String firstName;
  final String lastName;
  final String dob;
  final String gender;
  final String imageUrl;
  CreatUserEvent(
      {required this.firstName,
      required this.lastName,
      required this.dob,
      required this.gender,
      required this.imageUrl});
}

class GetUserEvent extends UserEvent {}

class ImageUserEvent extends UserEvent {
  final String imageUrl;

  ImageUserEvent({required this.imageUrl});
}

class UpdateUserEvent extends UserEvent {
  final String firstName;
  final String lastName;
  final String dob;
  final String gender;
  final String imageUrl;
  UpdateUserEvent(
      {required this.firstName,
      required this.lastName,
      required this.dob,
      required this.gender,
      required this.imageUrl});
}

class UserEvent {}
