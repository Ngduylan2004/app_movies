part of 'signup_bloc.dart';

class SignupFailure extends SignupState {
  final String error;

  SignupFailure(this.error);
}

class SignupInitial extends SignupState {}

class SignupLoading extends SignupState {}

class SignupState {}

class SignupSuccess extends SignupState {}
