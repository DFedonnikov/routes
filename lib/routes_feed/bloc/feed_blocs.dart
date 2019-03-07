import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:routes/routes_feed/bloc/feed_events.dart';
import 'package:routes/routes_feed/bloc/feed_states.dart';
import 'package:routes/routes_feed/data/feed_repo.dart';
import 'package:rxdart/rxdart.dart';

class MainFeedBloc extends Bloc<MainFeedEvent, MainFeedState> {
  final FeedRepo _feedRepo;

  MainFeedBloc(this._feedRepo);

  @override
  MainFeedState get initialState => FeedInitial();

  @override
  Stream<MainFeedEvent> transform(Stream<MainFeedEvent> events) {
    return (events as Observable<MainFeedEvent>)
        .debounce(Duration(microseconds: 500));
  }

  @override
  Stream<MainFeedState> mapEventToState(
      MainFeedState currentState, MainFeedEvent event) {
    if (event is Fetch && !_hasFetchedAllData(currentState)) {
      if (currentState is FeedInitial) {
        return loadFirstPage();
      } else if (currentState is FeedLoaded) {
        return loadNextPage(currentState);
      }
    }
    return Observable.just(currentState);
  }

  Stream<MainFeedState> loadFirstPage() => Observable.just(FeedLoading())
          .concatMap((value) => _getFeed(1))
          .map((data) {
        return data.isEmpty
            ? FeedLoaded(data: data, hasMoreData: false, currentPage: 1)
            : FeedLoaded(data: data, hasMoreData: true, currentPage: 1);
      });

  Stream<MainFeedState> loadNextPage(FeedLoaded currentState) =>
      _getFeed(currentState.currentPage + 1).map((data) {
        if (data.isEmpty) {
          return currentState.copyWith(hasMoreData: false);
        } else {
          return FeedLoaded(
              data: currentState.data + data,
              hasMoreData: true,
              currentPage: currentState.currentPage + 1);
        }
      });

  Stream<List<String>> _getFeed(int page) => _feedRepo.getFeed(page);

  bool _hasFetchedAllData(MainFeedState currentState) =>
      currentState is FeedLoaded && !currentState.hasMoreData;
}
