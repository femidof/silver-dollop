import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pinger/auth/auth.dart';
import 'package:pinger/services/cloud_storage_service.dart';
import 'package:pinger/services/db_service.dart';
import 'package:pinger/services/navigation_service.dart';
import 'package:pinger/services/media_service.dart';
import 'package:pinger/services/snackbar_service.dart';
import 'package:provider/provider.dart';

class RegisterationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegisterationPage> {
  double _deviceHeight;
  double _deviceWidth;

  GlobalKey<FormState> _formKey;
  AuthProvider _auth;
  File _image;
  String _name;
  String _password;
  String _email;

  _RegistrationPageState() {
    _formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      //TODO: change the color of registeration page if it is not nice
      backgroundColor: Colors.grey[400],
      body: Container(
        alignment: Alignment.center,
        child: ChangeNotifierProvider<AuthProvider>.value(
          value: AuthProvider.instance,
          child: registerationPageUI(),
        ),
      ),
    );
  }

  Widget registerationPageUI() {
    return Builder(
      builder: (BuildContext _context) {
        SnackBarService.instance.buildContext = _context;
        _auth = Provider.of<AuthProvider>(_context);
        return Container(
          height: _deviceHeight * 0.75,
          //used 0.06 instead of 0.10
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.06),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _headingWidget(),
              _inputForm(),
              _registerButton(),
              _backToLoginPageButton(),
            ],
          ),
        );
      },
    );
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
            "We're glad you're here!",
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
          ),
          Text(
            "Please enter in your details.",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w200),
          ),
        ],
      ),
    );
  }

  Widget _inputForm() {
    return Container(
      height: _deviceHeight * 0.35,
      child: Form(
        key: _formKey,
        onChanged: () {
          _formKey.currentState.save();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _imageSelectorWidget(),
            _nameTextField(),
            _emailTextField(),
            _passwordTextField(),
          ],
        ),
      ),
    );
  }

  Widget _imageSelectorWidget() {
    return Center(
      child: GestureDetector(
        onTap: () async {
          File _imageFile = await MediaService.instance.getImageFromLibrary();

          setState(() {
            _image = _imageFile;
            _image = _imageFile;
          });
        },
        child: Container(
          height: _deviceHeight * 0.10,
          width: _deviceHeight * 0.10,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(200),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: _image != null
                  ? FileImage(_image)
                  : NetworkImage(
                      "https://cdn0.iconfinder.com/data/icons/occupation-002/64/programmer-programming-occupation-avatar-512.png"),
            ),
          ),
        ),
      ),
    );
  }

  Widget _nameTextField() {
    return TextFormField(
      autocorrect: false,
      style: TextStyle(
        color: Colors.black,
      ),
      validator: (_input) {
        return _input.length != 0 ? null : "Please enter a name";
      },
      // onSaved: (_input) {
      //   setState(() {
      //     _email = _input;
      //   });
      // },
      onChanged: (_input) {
        setState(() {
          _name = _input;
        });
      },
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintText: "Full Name",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
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
        hintText: "Email",
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
      autocorrect: false,
      obscureText: true,
      style: TextStyle(
        color: Colors.black,
      ),
      validator: (_input) {
        return _input.length != 0 ? null : "Please enter a valid password";
      },
      // onSaved: (_input) {
      //   setState(() {
      //     _email = _input;
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

  Widget _registerButton() {
    return _auth.status != AuthStatus.Authenticating
        ? Container(
            child: Center(
              child: MaterialButton(
                onPressed: () async {
                  if (_formKey.currentState.validate() && _image != null) {
                    _auth.registerUserWithEmailAndPassword(_email, _password,
                        (String _uid) async {
                      var _result = await CloudStorageService.instance
                          .uploadUserImage(_uid, _image);
                      var _imageURL = await _result.ref.getDownloadURL();
                      await DBService.instance
                          .createUserInDB(_uid, _name, _email, _imageURL);
                    });
                  }
                },
                child: Text(
                  "REGISTER",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                color: Colors.blue,
              ),
            ),
          )
        : Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
  }

  Widget _backToLoginPageButton() {
    return GestureDetector(
      onTap: () {
        NavigationService.instance.goBack();
      },
      child: Container(
        height: _deviceHeight * 0.06,
        width: _deviceWidth,
        child: Icon(
          Icons.arrow_back,
          size: 40,
        ),
      ),
    );
  }
}
