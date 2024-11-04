part of 'signup_bloc.dart';

class SignEventOne extends SignupEvent {
  final String email;
  final String pass;
  final String username;

  SignEventOne(this.email, this.pass, this.username);
}

class SignEventOut extends SignupEvent {}

class SignupEvent {}

class SignupEventGoogle extends SignupEvent {}
