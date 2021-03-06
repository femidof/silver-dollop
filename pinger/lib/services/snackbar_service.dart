import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackBarService {
  BuildContext _buildContext;
  static SnackBarService instance = SnackBarService();
  SnackBarService() {}

  set buildContext(BuildContext _context) {
    _buildContext = _context;
  }

  void showSnackBarError(String _message) {
    Scaffold.of(_buildContext).showSnackBar(
      SnackBar(
        content: Text(
          _message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        duration: Duration(
          seconds: 3,
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  void showSnackBarSuccess(String _message) {
    Scaffold.of(_buildContext).showSnackBar(
      SnackBar(
        content: Text(
          _message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        duration: Duration(
          seconds: 3,
        ),
        backgroundColor: Colors.green,
      ),
    );
  }
}
