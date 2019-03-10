import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:routes/routes_feed/bloc/feed_events.dart';
import 'package:routes/routes_feed/bloc/feed_states.dart';
import 'package:routes/routes_feed/data/feed_repo.dart';
import 'package:routes/routes_feed/data/model/feed_models.dart';
import 'package:rxdart/rxdart.dart';

class MainFeedBloc extends FeedBloc {
  final FeedRepo _feedRepo;

  MainFeedBloc(this._feedRepo);

  @override
  Stream<List<RouteCardModel>> _getFeed(int page) => _feedRepo.getFeed(page);
}

abstract class FeedBloc extends Bloc<FeedEvent, FeedBlocState> {
  @override
  FeedBlocState get initialState => FeedLoading();

  @override
  Stream<FeedEvent> transform(Stream<FeedEvent> events) {
    return (events as Observable<FeedEvent>)
        .debounce(Duration(microseconds: 500));
  }

  @override
  Stream<FeedBlocState> mapEventToState(FeedBlocState currentState, FeedEvent event) {
    if (event is Fetch && !_hasFetchedAllData(currentState)) {
      if (currentState is FeedLoading) {
        return loadFirstPage();
      } else if (currentState is FeedLoaded) {
        return loadNextPage(currentState);
      }
    }
    return Observable.just(currentState);
  }

  Stream<FeedBlocState> loadFirstPage() => _getFeed(1).map((data) {
        return data.isEmpty
            ? FeedLoaded(data: data, hasMoreData: false, currentPage: 1)
            : FeedLoaded(data: data, hasMoreData: true, currentPage: 1);
      });

  Stream<FeedBlocState> loadNextPage(FeedLoaded currentState) =>
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

  Stream<List<RouteCardModel>> _getFeed(int page);

  bool _hasFetchedAllData(FeedBlocState currentState) =>
      currentState is FeedLoaded && !currentState.hasMoreData;
}
