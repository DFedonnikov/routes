import 'package:bloc/bloc.dart';
import 'package:routes/auth/data/auth_repo.dart';
import 'auth_events.dart';
import 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;

  AuthBloc(this._authRepo);

  @override
  AuthState get initialState => AuthUninitialized();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      final bool isAuthenticated = await _authRepo.isAuthenticated();
      if (isAuthenticated) {
        yield AuthAuthenticated();
      } else {
        yield AuthUnauthenticated();
      }
    }

    if (event is SignedIn) {
      yield AuthAuthenticated();
    }
    if (event is SignedOut) {
      _authRepo.signOut();
      yield AuthUnauthenticated();
    }
  }


}
