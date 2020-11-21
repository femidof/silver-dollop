import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinger/services/navigation_service.dart';
import 'package:pinger/services/snackbar_service.dart';

enum AuthStatus {
  NotAuthenticated,
  Authenticating,
  Authenticated,
  UserNotFound,
  Error,
}

class AuthProvider extends ChangeNotifier {
  User user;
  AuthStatus status;
  FirebaseAuth _auth;
  static AuthProvider instance = AuthProvider();

  AuthProvider() {
    _auth = FirebaseAuth.instance;
    _checkCurrentUserIsAuthenticated();
  }

  void _autoLogin() {
    if (user != null) {
      NavigationService.instance.navigateToReplacement("home");
    }
  }

  void _checkCurrentUserIsAuthenticated() async {
    //TODO: WORK ON THE AUTO LOGIN ERROR
    //user = await _auth.currentUser();

    if (user != null) {
      notifyListeners();
      _autoLogin();
    }
  }

  void loginUserWIthEmailAndPassword(String _email, String _password) async {
    status = AuthStatus.Authenticating;
    notifyListeners();
    try {
      UserCredential _result = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      user = _result.user;
      status = AuthStatus.Authenticated;
      SnackBarService.instance.showSnackBarSuccess(
          "Successfully Signed In, Welcome ${user.email} ");
      // Navigate to HomePage
    } catch (e) {
      status = AuthStatus.Error;
      // displays error

      SnackBarService.instance.showSnackBarError("Error Authenticating");
      print(e);
    }
    notifyListeners();
  }
}
