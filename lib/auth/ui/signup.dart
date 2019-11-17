import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:routes/auth/bloc/signup/signup_bloc.dart';
import 'package:routes/auth/bloc/signup/signup_events.dart';
import 'package:routes/auth/bloc/signup/signup_states.dart';
import 'package:routes/uikit/Input.dart';

import '../../Constants.dart';
import '../../colors.dart';
import '../../common_widgets.dart';

class CreateUserArgs {
  final String email;
  final String password;

  CreateUserArgs(this.email, this.password);
}

class CreateUserWidget extends StatefulWidget {
  @override
  State createState() {
    final kiwi.Container _container = kiwi.Container();
    return CreateUserState(_container<SignUpBloc>(SIGN_UP_BLOC));
  }
}

class CreateUserState extends State<CreateUserWidget> {
  final SignUpBloc _signUpBloc;
  final _displayNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  CameraController _cameraController;
  List<CameraDescription> cameras;

  CreateUserState(this._signUpBloc);

  @override
  void initState() async {
    super.initState();
    cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      } else {
        _signUpBloc.dispatch(InitCamera());
      }
    });
  }

  @override
  void didChangeDependencies() {
    final CreateUserArgs args = ModalRoute.of(context).settings.arguments;
    _signUpBloc.dispatch(StartSignUp(args.email, args.password));
  }

  @override
  void dispose() {
    _signUpBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpBloc>(
      builder: (_) => _signUpBloc,
      child: Scaffold(
          backgroundColor: mercury,
          appBar: EmptyAppBar(),
          body: BlocBuilder<SignUpBloc, SignUpState>(
            builder: (BuildContext context, SignUpState state) {
              return _topPart(state);
            },
          )),
    );
  }

  Widget _topPart(SignUpState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: _buildAvatar(state),
          flex: 4,
        ),
        Flexible(
          child: buildInputField(_displayNameController,
              left: 96, top: 270, right: 96, hint: "display name"),
          flex: 2,
        ),
        Flexible(
          child: buildInputField(_userNameController,
              left: 96, top: 24, right: 96, hint: "email"),
          flex: 2,
        ),
        Flexible(
          child: buildInputField(_passwordController,
              left: 96,
              top: 24,
              right: 96,
              hint: "password",
              obscureText: true),
          flex: 2,
        )
      ],
    );
  }

  Widget _buildAvatar(SignUpState state) {
    if (state is CameraInitialized && _cameraController.value.isInitialized) {
      return Padding(
          padding: EdgeInsets.only(top: ScreenUtil.getInstance().setWidth(48)),
          child: AspectRatio(
            aspectRatio: _cameraController.value.aspectRatio,
            child: CameraPreview(_cameraController),
          ));
    } else {
      return Padding(
          padding: EdgeInsets.only(top: ScreenUtil.getInstance().setWidth(48)),
          child: CircleAvatar(
            radius: ScreenUtil.getInstance().setWidth(240),
          ));
    }
  }
}
