import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {}

class SignUpInitial extends SignUpState {
  @override
  String toString() {
    return 'SignUpInitial';
  }
}

class CameraInitialized extends SignUpState {

  @override
  String toString() {
    return 'CameraInitialized{}';
  }
}
