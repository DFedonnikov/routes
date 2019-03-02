import 'dart:async';
import 'dart:io';

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
  Stream<MainFeedState> mapEventToState(
      MainFeedState currentState, MainFeedEvent event) {
    if (event is OpenFeed) {
      return startLoading();
    } else if (event is LoadingStarted) {
      return getFeed();
    } else {
      return Observable.just(FeedInitial());
    }
  }

  Stream<MainFeedState> startLoading() async* {
    yield FeedLoading();
    dispatch(LoadingStarted());
  }

  Stream<MainFeedState> getFeed() =>
      _feedRepo.getFeed().map((data) => FeedLoaded(data));
}
