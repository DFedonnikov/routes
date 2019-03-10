import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routes/routes_feed/bloc/feed_blocs.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:routes/routes_feed/bloc/feed_events.dart';
import 'package:routes/routes_feed/bloc/feed_states.dart';
import 'package:routes/routes_feed/data/model/feed_models.dart';
import 'package:routes/routes_feed/ui/detailed_widgets.dart';

class MainFeedWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainFeedState();
}

class _MainFeedState extends State<MainFeedWidget> {
  final kiwi.Container _container = kiwi.Container();
  final ScrollController _controller = ScrollController();
  final _scrollThreshold = 200.0;
  MainFeedBloc _mainFeedBloc;

  @override
  void initState() {
    _mainFeedBloc = _container<MainFeedBloc>();
    _controller.addListener(onScroll);
    _mainFeedBloc.dispatch(Fetch());
    super.initState();
  }

  @override
  void dispose() {
    _mainFeedBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 225, 225, 225),
      body: BlocBuilder(
        bloc: _mainFeedBloc,
        builder: (BuildContext context, MainFeedState state) {
          if (state is FeedLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is FeedLoaded) {
            return _listWithIndicator(state);
          }
        },
      ),
    );
  }

  Widget _listWithIndicator(FeedLoaded state) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return index >= state.data.length
            ? _loadingIndicator()
            : RouteCard(state.data[index], index == 0);
      },
      itemCount: state.hasMoreData ? state.data.length + 1 : state.data.length,
      controller: _controller,
    );
  }

  Widget _loadingIndicator() {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }

  void onScroll() {
    final maxScroll = _controller.position.maxScrollExtent;
    final currentScroll = _controller.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _mainFeedBloc.dispatch(Fetch());
    }
  }
}

class RouteCard extends StatelessWidget {
  final RouteCardModel _data;
  final bool _isFirst;

  final Color _textColor = Color.fromARGB(200, 125, 125, 125);

  RouteCard(this._data, this._isFirst);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(28.0, _isFirst ? 18.0 : 2.0, 28.0, 2.0),
        child: InkWell(
          child: Card(
            child: Column(
              children: <Widget>[
                _routePreview(),
                _routeLocation(),
                _routeName(),
                _routeDescription(),
              ],
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
            ),
            elevation: 8.0,
          ),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RouteDetailed(_data))),
        ));
  }

  Widget _routePreview() {
    return Image.asset(
      _data.imgUrl,
      fit: BoxFit.fill,
    );
  }

  Widget _routeLocation() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        _data.location,
        style: TextStyle(color: _textColor),
      ),
    );
  }

  Widget _routeName() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 10.0, right: 8.0),
      child: Text(
        _data.name,
        style: TextStyle(fontSize: 24.0, color: _textColor),
      ),
    );
  }

  Widget _routeDescription() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 8.0),
      child: Text(
        _data.descrpition,
        style: TextStyle(fontSize: 14.0, color: _textColor),
      ),
    );
  }
}
