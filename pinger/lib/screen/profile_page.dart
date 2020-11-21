import 'package:flutter/material.dart';
import 'package:pinger/auth/auth.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  final double _height;
  final double _width;

  ProfilePage(this._height, this._width);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      height: _height,
      width: _width,
      child: ChangeNotifierProvider<AuthProvider>.value(
        value: AuthProvider.instance,
        child: _profilePageUI(),
      ),
    );
  }

  Widget _profilePageUI() {
    return Builder(
      builder: (BuildContext _context) {
        var _auth = Provider.of<AuthProvider>(_context);
        return Center(
          child: SizedBox(
            height: _height * 0.50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _userImageWidget("https://i.pravatar.cc/150?img=3"),
                _userNameWidget("Tolu D"),
                _userEmailWidget("duro1210@gmail.com"),
                _logoutButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _userImageWidget(String _image) {
    double _imageRadius = _height * 0.2;

    return Container(
      height: _imageRadius,
      width: _imageRadius,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_imageRadius),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(_image),
        ),
      ),
    );
  }

  Widget _userNameWidget(String _userName) {
    return Container(
      height: _height * 0.05,
      width: _width,
      child: Text(
        _userName,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _userEmailWidget(String _email) {
    return Container(
      height: _height * 0.03,
      width: _width,
      child: Text(
        _email,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
    );
  }

  Widget _logoutButton() {
    return Container(
      height: _height * 0.06,
      width: _width * 0.8,
      child: MaterialButton(
        onPressed: () {},
        color: Colors.red,
        child: Text(
          "Log Out",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}
