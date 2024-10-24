part of 'signup_bloc.dart';

class SignupFailure extends SignupState {
  final String message;

  SignupFailure({required this.message});
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupState {}

class SignupSuccess extends SignupState {}
