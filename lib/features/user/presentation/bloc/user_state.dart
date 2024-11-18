part of 'user_bloc.dart';

class ImageUserState extends UserState {
  final String imageUrl;
  const ImageUserState({required this.imageUrl});
}

final class UpdateUserState extends UserState {
  final String firstName;
  final String lastName;
  final String dob;
  final String gender;
  final String imageUrl;

  const UpdateUserState({
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.gender,
    required this.imageUrl,
  }) : super();
}

class UserGetState extends UserState {
  final String email;
  final String firstName;
  final String lastName;
  final String dob;
  final String gender;

  const UserGetState({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.gender,
  });
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserSuccess extends UserState {}
