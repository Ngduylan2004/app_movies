import 'package:app_movies/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  // final AuthDataSource _authDataSource;
  final AuthRepository _authRepository;
  SignInBloc(this._authRepository) : super(const SignInInitial()) {
    on<SignCheckEvent>((event, emit) async {
      emit(const SignInLoading());
      final results = await _authRepository.signIpWithUsernamePassword(
          event.email, event.passWord);
      results.fold(
        (l) => emit(SignInFailure('lỗi đăng nhập: ${l.toString()}')),
        (r) => emit(const SignInSuccess('đăng nhập thành công', '')),
      );
    });

    on<SignWithGoogle>((event, emit) async {
      try {
        await _authRepository.signInWithGoogle();
        emit(const SignInSuccess('đăng nhập thành công', ''));
      } catch (e) {
        emit(SignInFailure('Lỗi không mong muốn: $e'));
      }
    });

    on<SignOutEvent>(
      (event, emit) async {
        await _authRepository.signOut();
        emit(SignoutSuccess());
      },
    );
  }
}
