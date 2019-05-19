import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:routes/auth/bloc/signup/signup_bloc.dart';
import 'package:routes/auth/bloc/signup/signup_events.dart';
import 'package:routes/auth/bloc/signup/signup_states.dart';

import '../../Constants.dart';
import '../../common_widgets.dart';

class CreateUserWidget extends StatefulWidget {
  final String email;
  final String password;

  CreateUserWidget(this.email, this.password);

  @override
  State createState() {
    final kiwi.Container _container = kiwi.Container();
    return CreateUserState(
        _container<SignUpBloc>(SIGN_UP_BLOC), email, password);
  }
}

class CreateUserState extends State<CreateUserWidget> {
  final SignUpBloc _signUpBloc;
  final String email;
  final String password;

  CreateUserState(this._signUpBloc, this.email, this.password);

  @override
  void initState() {
    super.initState();
    _signUpBloc.dispatch(StartSignUp(email, password));
  }

  @override
  void dispose() {
    _signUpBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: EmptyAppBar(),
        body: BlocBuilder<SignUpEvent, SignUpState>(
          bloc: _signUpBloc,
          builder: (BuildContext context, SignUpState state) {},
        ));
  }
}
