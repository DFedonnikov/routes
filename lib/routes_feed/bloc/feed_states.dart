import 'package:equatable/equatable.dart';

abstract class MainFeedState extends Equatable {}

class FeedInitial extends MainFeedState {
  @override
  String toString() {
    return 'FeedInitial';
  }
}

class FeedLoading extends MainFeedState {
  @override
  String toString() {
    return 'FeedLoading';
  }
}

class FeedLoaded extends MainFeedState {
  final String data;

  FeedLoaded(this.data);

  @override
  String toString() {
    return data;
  }
}
