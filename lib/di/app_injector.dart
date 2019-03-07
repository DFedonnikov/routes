import 'package:kiwi/kiwi.dart';
import 'package:routes/routes_feed/bloc/feed_blocs.dart';
import 'package:routes/routes_feed/data/feed_repo.dart';

part 'app_injector.g.dart';

abstract class Injector {
  @Register.singleton(FeedRepo, name: 'mockFeedRepo', from: MockFeedRepo)
  @Register.factory(MainFeedBloc, resolvers: {FeedRepo: 'mockFeedRepo'})
  void configure();
}

void inject() {
  var injector = _$Injector();
  injector.configure();
}
