import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:routes/auth/data/auth_repo.dart';
import '../auth_bloc.dart';
import '../auth_events.dart';
import 'login_events.dart';
import 'login_states.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthBloc _authBloc;
  final AuthRepo _authRepo;

  LoginBloc(this._authBloc, this._authRepo);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
      LoginState currentState, LoginEvent event) async* {
    if (event is SignIn) {
      yield LoginLoading();
      try {
        await _authRepo.signIn(event.email, event.password);
        _authBloc.dispatch(SignedIn());
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error.toString());
      }
    } else if (event is GoogleSignIn) {
      yield LoginLoading();
      try {
        await _authRepo.googleSignIn();
        _authBloc.dispatch(SignedIn());
      } catch (error) {
        yield LoginFailure(error.toString());
      }
    } else if (event is FacebookSignIn) {
      yield LoginLoading();
      try {
        await _authRepo.facebookSignIn();
        _authBloc.dispatch(SignedIn());
      } catch (error) {
        yield LoginFailure(error.toString());
      }
    } else if (event is SignUp) {
      yield LoginLoading();
      _authBloc.dispatch(NewUser(event.email, event.password));
    }
  }
}
