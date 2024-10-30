part of 'signup_bloc.dart';

class SignupEvent {
  final String email;
  final String pass;
  final String username;

  SignupEvent(this.email, this.pass, this.username);
}
