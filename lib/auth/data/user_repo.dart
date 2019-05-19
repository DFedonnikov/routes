import 'package:firebase_auth/firebase_auth.dart';
import 'package:routes/auth/data/user_source.dart';

abstract class UserRepo {
  Future<FirebaseUser> getUser();
}

class UserRepoImpl extends UserRepo {

  final LocalUserSource _localUserSource;
  final RemoteUserSource _remoteUserSource;

  UserRepoImpl(this._localUserSource, this._remoteUserSource);

  @override
  Future<FirebaseUser> getUser() {
      var user = _localUserSource.getUser();
      if (user != null) {
        return Future.value(user);
      } else {
        return _remoteUserSource.getUser();
      }
  }
}
