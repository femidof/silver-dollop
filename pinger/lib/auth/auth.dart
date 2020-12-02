import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pinger/services/navigation_service.dart';
import 'package:pinger/services/snackbar_service.dart';
import 'package:pinger/services/db_service.dart';

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
      await DBService.instance.updateUserLastSeenTime(user.uid);
      NavigationService.instance.navigateToReplacement("home");
      // NavigationService.instance.navigateToReplacement("profileui");
    } catch (e) {
      status = AuthStatus.Error;
      // displays error
      user = null;

      SnackBarService.instance.showSnackBarError("Error Authenticating");
      print(e);
    }
    notifyListeners();
  }

  void registerUserWithEmailAndPassword(String _email, String _password,
      Future<void> onSuccess(String _uid)) async {
    status = AuthStatus.Authenticating;
    notifyListeners();
    try {
      UserCredential _result = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      user = _result.user;
      status = AuthStatus.Authenticated;
      await onSuccess(user.uid);
      SnackBarService.instance.showSnackBarSuccess("Welcome ${user.email} ");
      await DBService.instance.updateUserLastSeenTime(user.uid);
      NavigationService.instance.goBack();
      NavigationService.instance.navigateToReplacement("home");
      // Navigate to home
    } catch (e) {
      status = AuthStatus.Error;
      user = null;
      SnackBarService.instance.showSnackBarError("Error Registering user");
      print(e);
    }
    notifyListeners();
  }

  void logoutUser(Future<void> onSuccess()) async {
    try {
      await _auth.signOut();
      user = null;
      status = AuthStatus.NotAuthenticated;
      await onSuccess();
      await NavigationService.instance.navigateToReplacement("login");
      SnackBarService.instance
          .showSnackBarError("You have successfully logged out!");
    } catch (e) {
      SnackBarService.instance
          .showSnackBarError("An error occured while logging out.");
    }
    notifyListeners();
  }
}
