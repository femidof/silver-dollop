import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavigationService {
  GlobalKey<NavigatorState> navigatorKey;
  static NavigationService instance = NavigationService();

  NavigationService() {
    navigatorKey = GlobalKey<NavigatorState>();
  }

  Future<dynamic> navigateToReplacement(String _routeName) {
    return navigatorKey.currentState.pushReplacementNamed(_routeName);
  }

  Future<dynamic> navigateTo(String _routeName) {
    return navigatorKey.currentState.pushNamed(_routeName);
  }

  Future<dynamic> navigateToRoute(CupertinoPageRoute _route) {
    return navigatorKey.currentState.push(_route);
  }

  void goBack() {
    //it was giving an error that void cannot be returned
    //https://github.com/FilledStacks/flutter-tutorials/issues/48 said to remove the return
    //said can also make the return type void instead on bool and keep the return
    navigatorKey.currentState.pop();
  }
}
