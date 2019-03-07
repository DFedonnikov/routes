import 'package:equatable/equatable.dart';

abstract class MainFeedEvent extends Equatable {}

class Fetch extends MainFeedEvent {
  @override
  String toString() {
    return 'Fetch';
  }
}

class LoadingStarted extends MainFeedEvent {
  @override
  String toString() {
    return 'StartLoading';
  }
}