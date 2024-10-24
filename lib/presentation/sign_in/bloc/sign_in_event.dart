part of 'sign_in_bloc.dart';

class SignInEvent {
  final String email;
  final String passWord;

  SignInEvent(this.email, this.passWord);
}

// class SignOutEvent extends SignInEvent {
//   SignOutEvent() : super("", ""); // Không cần email và password cho logout
// }
