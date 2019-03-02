import 'package:equatable/equatable.dart';

abstract class MainFeedEvent extends Equatable {}

class OpenFeed extends MainFeedEvent {
  @override
  String toString() {
    return 'OpenFeed';
  }
}
class LoadingStarted extends MainFeedEvent {
  @override
  String toString() {
    return 'StartLoading';
  }
}
