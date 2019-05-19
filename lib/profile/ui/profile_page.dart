import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:routes/auth/bloc/auth_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:routes/auth/bloc/auth_events.dart';

import '../../Constants.dart';
import '../../colors.dart';

class ProfilePage extends StatefulWidget {
  @override
  State createState() {
    final kiwi.Container _container = kiwi.Container();
    return _ProfilePageState(_container<AuthBloc>(AUTH_BLOC));
  }
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthBloc _authBloc;

  _ProfilePageState(this._authBloc);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mercury,
        body: SafeArea(
            child: Column(
          children: <Widget>[
            Expanded(
              child: buildProfileInfo(),
              flex: 1,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(color: Colors.green),
              ),
              flex: 1,
            )
          ],
        )));
  }

  Widget buildProfileInfo() {
    return Table(columnWidths: {
              1: FlexColumnWidth(1.6),
              2: FlexColumnWidth(0.5)
            }, children: [
              TableRow(children: [
                buildAvatar(),
                buildUserName(),
                buildSignOut()
              ])
            ]);
  }

  Widget buildAvatar() {
    return Padding(
                  padding: EdgeInsets.only(top: 24, left: 48),
                  child: Container(
                      child: Icon(
                        Icons.face,
                        size: 200,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(48)))));
  }

  Widget buildUserName() {
    return Padding(
                  padding: EdgeInsets.only(left: 24, top: 64),
                  child: Text(
                    "User name fdskfsdlfnlsfjlsdkfsdfsfasfsfs",
                    style: TextStyle(fontSize: 46),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ));
  }

  Widget buildSignOut() {
    return IconButton(
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                  iconSize: 48,
                  onPressed: () => _authBloc.dispatch(SignedOut()));
  }
}
