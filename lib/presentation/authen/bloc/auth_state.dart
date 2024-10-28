part of 'auth_bloc.dart';

final class AuthInitial extends AuthState {}

final class AuthLogin extends AuthState {}

final class AuthNoLogin extends AuthState {}

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}
