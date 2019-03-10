import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:routes/routes_feed/data/model/feed_models.dart';

class RouteDetailed extends StatelessWidget {
  final RouteCardModel _model;
  final Color _textColor = Color.fromARGB(200, 125, 125, 125);

  RouteDetailed(this._model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: <Widget>[
            previewSlider(),
            _routeName(),
            _author(),
            _routeDescription(),
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min),
    );
  }

  //todo make slider
  Widget previewSlider() {
    return Image.asset(
      _model.imgUrl,
      fit: BoxFit.fill,
    );
  }

  Widget _routeName() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 18.0, right: 16.0),
      child: Text(
        _model.name,
        style: TextStyle(fontSize: 36.0, color: _textColor),
      ),
    );
  }

  Widget _author() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0),
      child: Text(
        "Author: " + "some author",
        style: TextStyle(fontSize: 18.0, color: _textColor),
      ),
    );
  }

  Widget _routeDescription() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 10.0, 8.0, 16.0),
      child: Text(
        _model.descrpition,
        style: TextStyle(fontSize: 18.0, color: _textColor),
      ),
    );
  }
}
