import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routes/di/app_injector.dart';
import 'package:routes/home_page.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:routes/Constants.dart';

import 'auth/bloc/auth_bloc.dart';
import 'auth/bloc/auth_events.dart';
import 'auth/bloc/auth_states.dart';
import 'auth/ui/login.dart';
import 'auth/ui/signup.dart';

void main() {
  inject();
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State createState() {
    final kiwi.Container _container = kiwi.Container();
    return _AppState(_container<AuthBloc>(AUTH_BLOC));
  }
}

class _AppState extends State<MyApp> {
  final AuthBloc _authBloc;

  _AppState(this._authBloc);

  @override
  void initState() {
    _authBloc.dispatch(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    _authBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      bloc: _authBloc,
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: new ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: BlocBuilder(
              bloc: _authBloc,
              builder: (BuildContext context, AuthState state) {
                if (state is AuthUninitialized) {
                  return SplashScreen();
                } else if (state is AuthAuthenticated) {
                  return HomePage();
                } else if (state is AuthLoading) {
                  return LoadingIndicator();
                } else if (state is AuthNewUser) {
                  return CreateUserWidget(state.email, state.password);
                } else {
                  return LoginPage();
                }
              })),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SvgPicture.asset(
      'assets/routes_logo.svg',
      width: 60 * MediaQuery.of(context).devicePixelRatio,
    )));
  }
}

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Center(child: CircularProgressIndicator());
}
