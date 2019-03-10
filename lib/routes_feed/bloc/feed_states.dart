import 'package:equatable/equatable.dart';
import 'package:routes/routes_feed/data/model/feed_models.dart';

abstract class MainFeedState extends Equatable {
  MainFeedState([List props = const []]) : super(props);
}

class FeedLoading extends MainFeedState {
  @override
  String toString() {
    return 'FeedLoading';
  }
}

class FeedLoaded extends MainFeedState {
  final List<RouteCardModel> data;
  final bool hasMoreData;
  final int currentPage;

  FeedLoaded({this.data, this.hasMoreData, this.currentPage})
      : super([data, hasMoreData, currentPage]);

  FeedLoaded copyWith({
    List<RouteCardModel> data,
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
