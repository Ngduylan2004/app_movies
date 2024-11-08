part of 'signup_bloc.dart';

class SignEventOne extends SignupEvent {
  final String email;
  final String pass;
  final String displayName;

  SignEventOne(this.email, this.pass, this.displayName);
}

class SignEventOut extends SignupEvent {}

class SignupEvent {}

class SignupEventGoogle extends SignupEvent {}
