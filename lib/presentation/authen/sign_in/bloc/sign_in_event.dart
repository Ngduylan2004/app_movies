part of 'sign_in_bloc.dart';

// class SigninInitial extends SignInEvent {
//    final String email;
//   final String passWord;

//    SignInInitial(this.email, this.passWord);

// }
class SignCheckEvent extends SignInEvent {
  final String email;
  final String passWord;

  SignCheckEvent(this.email, this.passWord);
}

class SignInEvent {}

class SignOutEvent extends SignInEvent {}

// class SignOutEvent extends SignInEvent {
//   SignOutEvent() : super("", ""); // Không cần email và password cho logout
// }
