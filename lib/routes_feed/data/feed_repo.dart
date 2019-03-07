import 'package:routes/routes_feed/data/model/feed_models.dart';
import 'package:rxdart/rxdart.dart';

abstract class FeedRepo {
  Observable<List<RouteCardModel>> getFeed(int page);
}

class MockFeedRepo implements FeedRepo {
  final String _location = "Netherlands";
  final String _name = "Route name";
  final String _description =
      "Optional route description, can be as long as short: tra-ta-ta-ta ta ta, "
      "bla bla bla Amstredam is very very cool";
  final String _imgUrl = 'assets/route_mock_preview.jpg';

  @override
  Observable<List<RouteCardModel>> getFeed(int page) => page > 10
      ? Observable.just(List())
      : Observable.timer(_generatePages(), Duration(milliseconds: 750));

  List<RouteCardModel> _generatePages() => List.generate(
      30, (index) => RouteCardModel(_location, _name, _description, _imgUrl));
}
