import 'package:rxdart/rxdart.dart';

class FeedRepo {
  Observable<String> getFeed() => Observable.timer("Loaded data", Duration(seconds: 7));
}
