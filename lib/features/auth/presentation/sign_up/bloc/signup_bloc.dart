import 'package:app_movies/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepository _authRepository;

  SignupBloc(this._authRepository) : super(SignupState()) {
    on<SignEventOne>((event, emit) async {
      emit(SignupLoading());
      final results = await _authRepository.signUpWithUsernamePassword(
        event.email,
        event.pass,
        event.displayName,
      );
      results.fold(
        (l) => emit(SignupFailure(l.toString())),
        (r) => emit(SignupSuccess()),
      );
    });
  }
}
