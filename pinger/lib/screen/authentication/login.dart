import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinger/auth/auth.dart';
import 'package:pinger/services/navigation_service.dart';
import 'package:pinger/services/snackbar_service.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // double _deviceHeight;
  double _deviceWidth;
  String _email;
  String _password;

  GlobalKey<FormState> _formkey;
  AuthProvider _auth;
  _LoginPageState() {
    _formkey = GlobalKey<FormState>();
  }
  @override
  Widget build(BuildContext context) {
    // _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white70,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              // child: Center(
              child: Shimmer.fromColors(
                child: Text(
                  "Pinger",
                  style: GoogleFonts.pacifico(fontSize: 40),
                ),
                baseColor: Colors.blue[400],
                highlightColor: Colors.redAccent[400],
              ),
              // ),
            ),
            ChangeNotifierProvider<AuthProvider>.value(
              value: AuthProvider.instance,
              child: _loginPageUI(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginPageUI() {
    return Builder(builder: (BuildContext _context) {
      SnackBarService.instance.buildContext = _context;
      _auth = Provider.of<AuthProvider>(_context);
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headingWidget(),
            _inputForm(),
          ],
        ),
      );
    });
  }

  Widget _headingWidget() {
    return Container(
      // height: _deviceHeight * 0.12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 90,
          ),
          Text(
            "Welcome Back",
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
          ),
          Text(
            "Please login to your account",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w200),
          ),
        ],
      ),
    );
  }

  Widget _inputForm() {
    return Container(
      child: Form(
        key: _formkey,
        onChanged: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 90,
            ),
            _emailTextField(),
            SizedBox(
              height: 20,
            ),
            _passwordTextField(),
            SizedBox(
              height: 50,
            ),
            _loginButton(),
            SizedBox(
              height: 30,
            ),
            _registerButton(),
          ],
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      autocorrect: false,
      style: TextStyle(
        color: Colors.black,
      ),
      validator: (_input) {
        return _input.length != 0 && _input.contains('@')
            ? null
            : "Please enter a valid email";
      },
      // onSaved: (_input) {
      //   setState(() {
      //     _email = _input;
      //   });
      // },
      onChanged: (_input) {
        setState(() {
          _email = _input;
        });
      },
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: "Email Address",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      obscureText: true,
      autocorrect: false,
      style: TextStyle(
        color: Colors.black,
      ),
      validator: (_input) {
        return _input.length != 0 && _input != null
            ? null
            : "Please enter a password";
      },
      // onSaved: (_input) {
      //   setState(() {
      //     _password = _input;
      //   });
      // },
      onChanged: (_input) {
        setState(() {
          _password = _input;
        });
      },
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: "Password",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return _auth.status == AuthStatus.Authenticating
        ? Center(child: CircularProgressIndicator())
        : Container(
            child: Center(
              child: MaterialButton(
                onPressed: () {
                  if (_formkey.currentState.validate()) {
                    // login User
                    _auth.loginUserWIthEmailAndPassword(_email, _password);
                    print("login");
                  }
                },
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                color: Colors.blue,
              ),
            ),
          );
  }

  Widget _registerButton() {
    return Center(
      child: GestureDetector(
        onTap: () {
          NavigationService.instance.navigateTo("register");
        },
        child: Container(
          child: Text(
            "REGISTER",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
