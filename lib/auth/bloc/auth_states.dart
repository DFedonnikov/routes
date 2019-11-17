import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {}

class AuthUninitialized extends AuthState {
  @override
  String toString() => 'AuthUninitialized';
}

class AuthAuthenticated extends AuthState {
  @override
  String toString() => 'AuthAuthenticated';
}

class AuthUnauthenticated extends AuthState {
  @override
  String toString() => 'AuthUnauthenticated';
}

class AuthNewUser extends AuthState {
  final String email;
  final String password;

  AuthNewUser(this.email, this.password);

  @override
  String toString() => 'AuthNewUser';
}
