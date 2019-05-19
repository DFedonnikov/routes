import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRepo {
  Future<FirebaseUser> signIn(String email, String password);

  Future<FirebaseUser> googleSignIn();

  Future<FirebaseUser> facebookSignIn();

  Future<FirebaseUser> signUp(String email, String password);

  Future<bool> isAuthenticated();

  void signOut();
}

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin _facebookLogin = FacebookLogin();

  @override
  Future<FirebaseUser> signIn(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<FirebaseUser> googleSignIn() async {
    GoogleSignInAccount account = await _googleSignIn.signIn();
    GoogleSignInAuthentication authentication = await account.authentication;
    FirebaseUser user = await _firebaseAuth.signInWithGoogle(
        idToken: authentication.idToken,
        accessToken: authentication.accessToken);

    return user;
  }

  @override
  Future<FirebaseUser> facebookSignIn() async {
    final FacebookLoginResult result =
        await _facebookLogin.logInWithReadPermissions(['email']);
    final FirebaseUser user = await _firebaseAuth.signInWithFacebook(
        accessToken: result.accessToken.token);
    return user;
  }

  @override
  Future<FirebaseUser> signUp(String email, String password) async {
    return _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  @override
  Future<bool> isAuthenticated() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user != null;
  }

  @override
  void signOut() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    if (user.providerId == "facebookId") {
      _facebookLogin.logOut();
    }
    _firebaseAuth.signOut();
  }
}
