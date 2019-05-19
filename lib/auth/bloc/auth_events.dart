import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  AuthEvent([List props = const []]) : super(props);
}

class AppStarted extends AuthEvent {
  @override
  String toString() => 'AppStarted';
}

class SignedIn extends AuthEvent {
  @override
  String toString() => 'SignedIn';
}

class SignedOut extends AuthEvent {
  @override
  String toString() => 'SignedOut';
}

class NewUser extends AuthEvent {

  final String email;
  final String password;

  NewUser(this.email, this.password) : super([email]);

  @override
  String toString() {
    return 'NewUser{}';
  }
}
