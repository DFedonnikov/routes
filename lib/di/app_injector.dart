import 'package:kiwi/kiwi.dart';
import 'package:routes/routes_feed/bloc/feed_blocs.dart';
import 'package:routes/routes_feed/data/feed_repo.dart';
import 'package:routes/Constants.dart';

part 'app_injector.g.dart';

abstract class Injector {
  @Register.singleton(FeedRepo, name: MOCK_FEED_REPO, from: MockFeedRepo)
  @Register.factory(FeedBloc, resolvers: {FeedRepo: MOCK_FEED_REPO}, from: MainFeedBloc, name: MAIN_FEED_BLOCK)
  void configure();
}

void inject() {
  var injector = _$Injector();
  injector.configure();
}
