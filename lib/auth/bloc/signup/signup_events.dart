import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  SignUpEvent([List props = const []]) : super(props);
}

class StartSignUp extends SignUpEvent {
  final String email;
  final String password;

  StartSignUp(this.email, this.password);

  @override
  String toString() {
    return 'StartSignUp{}';
  }

}
