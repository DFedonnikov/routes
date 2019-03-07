import 'package:equatable/equatable.dart';

abstract class MainFeedState extends Equatable {
  MainFeedState([List props = const []]) : super(props);
}

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

class PageLoading extends MainFeedState {
  @override
  String toString() {
    return 'PageLoading';
  }
}

class FeedLoaded extends MainFeedState {
  final List<String> data;
  final bool hasMoreData;
  final int currentPage;

  FeedLoaded({this.data, this.hasMoreData, this.currentPage})
      : super([data, hasMoreData, currentPage]);

  FeedLoaded copyWith({
    List<String> data,
    bool hasMoreData,
    int currentPage,
  }) {
    return FeedLoaded(
        data: data ?? this.data,
        hasMoreData: hasMoreData ?? this.hasMoreData,
        currentPage: currentPage ?? this.currentPage);
  }

  @override
  String toString() {
    return 'FeedLoaded';
  }
}
