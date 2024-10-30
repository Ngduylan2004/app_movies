part of 'sign_in_bloc.dart';

// Trạng thái khi đăng nhập thất bại
class SignInFailure extends SignInState {
  final String error;

  const SignInFailure(this.error);
  @override
  List<Object?> get props => [error];
}

// Trạng thái khởi tạo
class SignInInitial extends SignInState {
  const SignInInitial();
}

// Trạng thái khi đang tải
class SignInLoading extends SignInState {
  const SignInLoading();
}

// Trạng thái cơ bản cho đăng nhập
abstract class SignInState extends Equatable {
  const SignInState();
  @override
  List<Object?> get props => [];
}

class SignInSuccess extends SignInState {
  final String userId;

  const SignInSuccess(this.userId);
  @override
  List<Object?> get props => [userId];
}

class SignoutSuccess extends SignInState {}
// class SignOutSuccess extends SignInState {}
