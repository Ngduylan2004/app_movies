part of 'sign_in_bloc.dart';

// Trạng thái khi đăng nhập thất bại
class SignInFailure extends SignInState {
  final String error;

  const SignInFailure(this.error);
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
abstract class SignInState {
  const SignInState();
}

// Trạng thái khi đăng nhập thành công
class SignInSuccess extends SignInState {
  final String userId;

  const SignInSuccess(this.userId);
}
