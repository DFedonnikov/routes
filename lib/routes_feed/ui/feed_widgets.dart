import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routes/routes_feed/bloc/feed_blocs.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:routes/routes_feed/bloc/feed_events.dart';
import 'package:routes/routes_feed/bloc/feed_states.dart';

class MainFeedWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainFeedState();
}

class _MainFeedState extends State<MainFeedWidget> {
  final kiwi.Container _container = kiwi.Container();
  MainFeedBloc _mainFeedBloc;

  @override
  void initState() {
    _mainFeedBloc = _container<MainFeedBloc>();
    _mainFeedBloc.dispatch(OpenFeed());
  }

  @override
  void dispose() {
    _mainFeedBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder(
        bloc: _mainFeedBloc,
        builder: (BuildContext context, MainFeedState state) {
          if (state is FeedInitial) {
            return Center(
              child: Text(state.toString()),
            );
          }
          if (state is FeedLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is FeedLoaded) {
            return Center(
              child: Text(state.toString()),
            );
          }
        },
      ),
    );
  }
}
