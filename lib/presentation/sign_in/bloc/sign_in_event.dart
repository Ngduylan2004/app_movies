part of 'sign_in_bloc.dart';

class SignInEvent extends Equatable {
  final String email;
  final String passWord;

  const SignInEvent(this.email, this.passWord);

  @override
  // TODO: implement props
  List<Object?> get props => [email, passWord];
}

// class SignOutEvent extends SignInEvent {
//   SignOutEvent() : super("", ""); // Không cần email và password cho logout
// }
