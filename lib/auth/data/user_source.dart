import 'package:firebase_auth/firebase_auth.dart';

abstract class LocalUserSource {

  FirebaseUser getUser();
  saveUser(FirebaseUser user);
}

class LocalUserSourceImpl extends LocalUserSource {

  FirebaseUser user;

  @override
  FirebaseUser getUser() {
    return user;
  }

  @override
  saveUser(FirebaseUser user) {
    this.user = user;
  }
}

abstract class RemoteUserSource {

  Future<FirebaseUser> getUser();
}

class RemotreUserSourceImpl extends RemoteUserSource {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<FirebaseUser> getUser() async => await _firebaseAuth.currentUser();
}