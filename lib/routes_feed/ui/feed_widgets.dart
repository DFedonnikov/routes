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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            return ListWithIndicator(state);
          }
        },
      ),
    );
  }

  Widget ListWithIndicator(FeedLoaded state) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return index >= state.data.length
            ? _loadingIndicator()
            : RouteCard(state.data[index]);
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
  final String data;

  RouteCard(this.data);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(data),
      ),
    );
  }
}
