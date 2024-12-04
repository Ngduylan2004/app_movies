import 'package:app_movies/features/auth/data/datasources/auth_data_source.dart';
import 'package:app_movies/features/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;
  AuthRepositoryImpl(this._authDataSource);
  @override
  Future<void> signInWithGoogle() async {
    await _authDataSource.signInWithGoogle();
  }

  @override
  Future<Either<Exception, bool>> signIpWithUsernamePassword(
      String email, String password) async {
    try {
      await _authDataSource.signInWithUsernamePassword(email, password);
      return const Right(true);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }

  @override
  Future<void> signOut() async {
    await _authDataSource.signOut();
  }

  @override
  Future<Either<Exception, bool>> signUpWithUsernamePassword(
      String email, String password, String displayName) async {
    try {
      await _authDataSource.signUpWithUsernamePassword(
          email, password, displayName);
      return const Right(true);
    } catch (e) {
      return Left(Exception(e.toString()));
    }
  }
}

// class LocalException implements Exception {
//   final String message;
//   LocalException(this.message);
// }
