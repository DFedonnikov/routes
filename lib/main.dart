import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routes/di/app_injector.dart';
import 'package:routes/home_page.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:routes/Constants.dart';

import 'Routes.dart';
import 'auth/bloc/auth_bloc.dart';
import 'auth/bloc/auth_events.dart';
import 'auth/bloc/auth_states.dart';
import 'auth/ui/login.dart';
import 'auth/ui/signup.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  inject();
  final kiwi.Container _container = kiwi.Container();
  runApp(BlocProvider(
    builder: (_) => _container<AuthBloc>(AUTH_BLOC),
    child: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State createState() {
    return _AppState();

  }
}

class _AppState extends State<MyApp> {
  @override
  void initState() {
    BlocProvider.of<AuthBloc>(context).dispatch(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<AuthBloc>(context).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        splash: (_) => SplashScreen(),
        home: (_) => HomePage(),
        login: (_) => LoginPage(),
        newUser: (_) => CreateUserWidget()
      },
      initialRoute: splash,
      title: 'Routes',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.getInstance().init(context);
    return BlocListener(
        bloc: BlocProvider.of<AuthBloc>(context),
        listener: (BuildContext context, AuthState state) {
          if (state is AuthUninitialized) {
            Navigator.of(context).pushNamed(splash);
          } else if (state is AuthAuthenticated) {
            Navigator.of(context).pushNamed(home);
          } else {
            Navigator.of(context).pushNamed(login);
          }
        },
        child: Center(
          child: SvgPicture.asset(
            'assets/routes_logo.svg',
            width: 60 * MediaQuery.of(context).devicePixelRatio,
          ),
        ));
  }
}
