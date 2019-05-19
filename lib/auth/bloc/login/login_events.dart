import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class SignIn extends LoginEvent {
  final String email;
  final String password;

  SignIn(this.email, this.password) : super([email, password]);

  @override
  String toString() {
    return 'SignIn{email: $email}';
  }
}

class GoogleSignIn extends LoginEvent {
  @override
  String toString() {
    return 'GoogleSignIn{}';
  }
}

class FacebookSignIn extends LoginEvent {
  @override
  String toString() {
    return 'FacebookSignIn{}';
  }
}

class SignUp extends LoginEvent {
  final String email;
  final String password;

  SignUp(this.email, this.password) : super([email]);

  @override
  String toString() {
    return 'SignUp{email: $email}';
  }
}
