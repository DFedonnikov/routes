import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:routes/auth/bloc/signup/signup_bloc.dart';
import 'package:routes/auth/bloc/signup/signup_events.dart';
import 'package:routes/auth/bloc/signup/signup_states.dart';
import 'package:routes/uikit/Input.dart';
import 'package:routes/extensions/Int.dart';

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

class CreateUserState extends State<CreateUserWidget>
    with TickerProviderStateMixin {
  final SignUpBloc _signUpBloc;
  final _displayNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  CameraController _cameraController;
  List<CameraDescription> cameras;

  CreateUserState(this._signUpBloc);

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  void _initCamera() async {
    cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.max);
  }

  @override
  void didChangeDependencies() {
    final CreateUserArgs args = ModalRoute
        .of(context)
        .settings
        .arguments;
    _signUpBloc.dispatch(StartSignUp(args.email, args.password));
  }

  @override
  void dispose() {
    _signUpBloc.dispose();
    _cameraController.dispose();
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
        children: getChildren(state));
  }

  List<Widget> getChildren(SignUpState state) {
    if (_isShowingCamera(state)) {
      return [Flexible(child: _buildAvatar(state), flex: 4), Container()];
    } else {
      return [
        Flexible(
          child: _buildAvatar(state),
          flex: 4,
        ),
        Flexible(
          child: buildInputField(_displayNameController,
              left: 24.dp(),
              top: 36.dp(),
              right: 24.dp(),
              hint: "display name"),
          flex: (_isShowingCamera(state)) ? 0 : 2,
        ),
        Flexible(
          child: buildInputField(_userNameController,
              left: 24.dp(), top: 8.dp(), right: 24.dp(), hint: "email"),
          flex: (_isShowingCamera(state)) ? 0 : 2,
        ),
        Flexible(
          child: buildInputField(_passwordController,
              left: 24.dp(),
              top: 8.dp(),
              right: 24.dp(),
              hint: "password",
              obscureText: true),
          flex: (_isShowingCamera(state)) ? 0 : 2,
        )
      ];
    }
  }

  bool _isShowingCamera(SignUpState state) {
    return state is CameraInitialized && _cameraController.value.isInitialized;
  }

  Widget _buildAvatar(SignUpState state) {
    double width;
    double height;
    Widget child;
    if ((_isShowingCamera(state))) {
      width = ScreenUtil.screenWidth;
      height = ScreenUtil.screenHeight;
      child = _buildCamera();
    } else {
      width = 88.dp();
      height = 88.dp();
      child = _buildAvatarPreview();
    }

    return AnimatedContainer(
        margin: EdgeInsets.only(top: (_isShowingCamera(state)) ? 0 : 12.dp()),
        width: width,
        height: height,
        foregroundDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.dp())
        ),
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 2000),
        child: child);
  }

  Widget _buildCamera() {
    return AspectRatio(
        aspectRatio: _cameraController.value.aspectRatio,
        child: CameraPreview(_cameraController));
  }

  Widget _buildAvatarPreview() {
    return GestureDetector(
        child: Container(color: Color.fromARGB(255, 255, 0, 0),),
        onTap: () => openCamera());
  }

  void openCamera() {
    _cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      } else {
        _signUpBloc.dispatch(InitCamera());
      }
    });
  }
}

class OverflowClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    final screenWidth = ScreenUtil.screenWidth;
    final screenHeight = ScreenUtil.screenHeight;

    return new Rect.fromLTRB(0, 0, size.width * 2, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
