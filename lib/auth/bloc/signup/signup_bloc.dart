import 'package:bloc/bloc.dart';
import 'package:routes/auth/bloc/signup/signup_events.dart';
import 'package:routes/auth/bloc/signup/signup_states.dart';
import 'package:routes/auth/data/auth_repo.dart';

import '../auth_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {

  final AuthBloc _authBloc;
  final AuthRepo _authRepo;

  SignUpBloc(this._authBloc, this._authRepo);

  @override
  SignUpState get initialState {}

  @override
  Stream<SignUpState> mapEventToState(
      SignUpState currentState, SignUpEvent event) {}
}
