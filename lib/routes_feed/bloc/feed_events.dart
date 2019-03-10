import 'package:equatable/equatable.dart';

abstract class FeedEvent extends Equatable {}

class Fetch extends FeedEvent {
  @override
  String toString() {
    return 'Fetch';
  }
}

class LoadingStarted extends FeedEvent {
  @override
  String toString() {
    return 'StartLoading';
  }
}