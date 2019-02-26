import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:routes/routes_feed/bloc/feed_events.dart';
import 'package:routes/routes_feed/bloc/feed_states.dart';

class MainFeedBloc extends Bloc<MainFeedEvent, MainFeedState> {
  @override
  MainFeedState get initialState => FeedInitial();

  @override
  Stream<MainFeedState> mapEventToState(
      MainFeedState currentState, MainFeedEvent event) async* {
    if (event is OpenFeed) {
      yield FeedLoading();
      sleep(const Duration(seconds: 3));
      yield FeedLoaded();
    }
  }
}
