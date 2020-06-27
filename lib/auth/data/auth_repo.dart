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
  Future<FirebaseUser> signIn(String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password)).user;
  }

  @override
  Future<FirebaseUser> googleSignIn() async {
    GoogleSignInAccount account = await _googleSignIn.signIn();
    GoogleSignInAuthentication authentication = await account.authentication;
    AuthCredential credential = GoogleAuthProvider.getCredential(idToken: authentication.idToken, accessToken: authentication.accessToken);
    return (await _firebaseAuth.signInWithCredential(credential)).user;
  }

  @override
  Future<FirebaseUser> facebookSignIn() async {
    final FacebookLoginResult result =
        await _facebookLogin.logInWithReadPermissions(['email']);
    AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: result.accessToken.token);
    return (await _firebaseAuth.signInWithCredential(credential)).user;
  }

  @override
  Future<FirebaseUser> signUp(String email, String password) async {
    return (await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password)).user;
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
