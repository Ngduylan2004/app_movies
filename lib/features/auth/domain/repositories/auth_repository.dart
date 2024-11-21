import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<void> signInWithGoogle();

  Future<Either<Exception, bool>> signIpWithUsernamePassword(
      String email, String password);
  Future<void> signOut();

  Future<Either<Exception, bool>> signUpWithUsernamePassword(
      String email, String password, String displayName);
}
