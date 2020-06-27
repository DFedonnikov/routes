import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:routes/auth/bloc/login/login_bloc.dart';
import 'package:routes/auth/bloc/login/login_events.dart';
import 'package:routes/auth/bloc/login/login_states.dart';
import 'package:routes/auth/ui/signup.dart';
import 'package:routes/uikit/Input.dart';
import 'package:routes/extensions/Int.dart';

import '../../Constants.dart';
import '../../Routes.dart';
import '../../colors.dart';
import '../../common_widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() {
    final kiwi.Container _container = kiwi.Container();
    return _LoginPageState(_container<LoginBloc>(LOGIN_BLOC));
  }
}

class _LoginPageState extends State<LoginPage> {
  final LoginBloc _loginBloc;

  _LoginPageState(this._loginBloc);

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: mercury,
        appBar: EmptyAppBar(),
        body: LoginForm(_loginBloc));
  }
}

class LoginForm extends StatefulWidget {
  final LoginBloc _loginBloc;

  LoginForm(this._loginBloc);

  @override
  State createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginBloc get _loginBloc => widget._loginBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        bloc: _loginBloc,
        builder: (BuildContext context, LoginState state) {
          if (state is LoginFailure) {
            _loginError(context, state.error);
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: _topPart(state),
                flex: 3,
              ),
              Flexible(child: _bottomPart(state), flex: 1)
            ],
          );
        });
  }

  Widget _topPart(LoginState state) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: _buildLogo(),
            flex: 4,
          ),
          Flexible(
            child: buildInputField(_userNameController,
                left: 24.dp(), top: 18.dp(), right: 24.dp(), hint: "email"),
            flex: 2,
          ),
          Flexible(
            child: buildInputField(_passwordController,
                left: 24.dp(),
                top: 8.dp(),
                right: 24.dp(),
                hint: "password",
                obscureText: true),
            flex: 2,
          ),
          Flexible(
            child: state is LoginLoading
                ? _buildProgressIndicator()
                : _buildContinueButton(state),
            flex: 3,
          )
        ]);
  }

  Widget _bottomPart(LoginState state) {
    return Padding(
        padding: EdgeInsets.only(bottom: dp(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: _buildJoinButton(state),
              flex: 1,
            ),
            Flexible(
              child: _buildGoogleLogin(state),
              flex: 1,
            ),
            Flexible(
              child: _buildFacebookLogin(state),
              flex: 1,
            )
          ],
        ));
  }

  Widget _buildLogo() {
    return Padding(
        padding: EdgeInsets.only(top: dp(48)),
        child: SvgPicture.asset(
          'assets/routes_logo.svg',
          width: dp(480),
        ));
  }

  double dp(double size) {
    return size / MediaQuery.of(context).devicePixelRatio;
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: EdgeInsets.only(top: dp(90)),
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.black),
      ),
    );
  }

  Widget _buildContinueButton(LoginState state) {
    return Padding(
        padding: EdgeInsets.only(top: dp(16)),
        child: _buildShadowedIcon(
            icon: Icons.arrow_forward,
            size: dp(240),
            x: dp(-4),
            y: dp(8),
            onPressed: state is! LoginLoading ? _onLoginButtonPressed : null));
  }

  Widget _buildShadowedIcon(
      {IconData icon, double size, double x, double y, Function() onPressed}) {
    return IconButton(
        padding: EdgeInsets.all(0),
        iconSize: size,
        icon: Stack(
          children: <Widget>[
            Positioned(
                left: x,
                top: y,
                child: Icon(
                  icon,
                  size: size,
                  color: Colors.black45,
                )),
            Container(
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: dp(2.0), sigmaY: dp(2.0)),
                    child: Container(
                      decoration:
                          BoxDecoration(color: Colors.white.withOpacity(0.0)),
                    ))),
            Icon(
              icon,
              size: size,
              color: Colors.black,
            )
          ],
        ),
        onPressed: onPressed);
  }

  _loginError(BuildContext context, String error) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(error),
        backgroundColor: Colors.red,
      ));
    });
  }

  _onLoginButtonPressed() {
    _loginBloc
        .dispatch(SignIn(_userNameController.text, _passwordController.text));
  }

  Widget _buildJoinButton(LoginState state) {
    return Padding(
        padding: EdgeInsets.only(top: dp(0), left: dp(96), right: dp(96)),
        child: GestureDetector(
            onTap: state is! LoginLoading ? _onSignUpPressed : null,
            child: Card(
                elevation: 8,
                child: SvgPicture.asset(
                  'assets/join_button.svg',
                ))));
  }

  _onSignUpPressed() => Navigator.of(context).pushNamed(newUser,
      arguments:
          CreateUserArgs(_userNameController.text, _passwordController.text));

  Widget _buildGoogleLogin(LoginState state) {
    return Padding(
        padding: EdgeInsets.only(top: dp(0), left: dp(96), right: dp(96)),
        child: GestureDetector(
            onTap: state is! LoginLoading ? _onGoogleLoginPressed : null,
            child: Card(
                elevation: 8,
                child: SvgPicture.asset('assets/google_login_button.svg'))));
  }

  _onGoogleLoginPressed() {
    _loginBloc.dispatch(GoogleSignIn());
  }

  Widget _buildFacebookLogin(LoginState state) {
    return Padding(
        padding: EdgeInsets.only(top: dp(0), left: dp(96), right: dp(96)),
        child: GestureDetector(
            onTap: state is! LoginLoading ? _onFacebookLoginPressed : null,
            child: Card(
                elevation: 8,
                child: SvgPicture.asset('assets/facebook_login_button.svg'))));
  }

  _onFacebookLoginPressed() {
    _loginBloc.dispatch(FacebookSignIn());
  }
}
