import 'package:rxdart/rxdart.dart';

abstract class FeedRepo {
  Observable<List<String>> getFeed(int page);
}

class MockFeedRepo implements FeedRepo {
  @override
  Observable<List<String>> getFeed(int page) => page > 10
      ? Observable.just(List())
      : Observable.timer(_generatePages(page), Duration(milliseconds: 750));

  List<String> _generatePages(int page) =>
      List.generate(30, (index) => (((page - 1) * 30) + index).toString());
}
