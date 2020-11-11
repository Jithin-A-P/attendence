import 'package:attendance/components/rounded_button.dart';
import 'package:attendance/constants.dart';
import 'package:attendance/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String ID = 'RegistrationScreen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email;
  String password;
  String confirmPassword;
  bool showSpinner = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 150.0,
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                controller: _passwordController,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                controller: _confirmController,
                onChanged: (value) {
                  confirmPassword = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Confirm your password',
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              RoundedButton(
                title: 'Sign Up',
                color: Colors.black87,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  if (password == confirmPassword) {
                    try {
                      final _newuser = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email,
                        password: password,
                      );
                      if (_newuser != null) {
                        Navigator.pushReplacementNamed(context, HomeScreen.ID);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      // TODO : Implement all edge cases for error catching
                      print(e);
                      setState(() {
                        showSpinner = false;
                      });
                    }
                  } else {
                    setState(() {
                      password = null;
                      confirmPassword = null;
                      showSpinner = false;
                      _passwordController.clear();
                      _confirmController.clear();
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text('Passwords doesn\'t match'),
                          duration: Duration(
                            seconds: 1,
                          ),
                        ),
                      );
                    });
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
