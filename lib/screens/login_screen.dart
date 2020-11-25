import 'package:events/screens/event_screen.dart';
import 'package:events/shared/authentication.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();

  bool _isLogin = true;
  String _userId;
  String _message;

  Authentication authentication;

  @override
  initState() {
    authentication = Authentication();
    _message = '';
    super.initState();
  }

  Future submit() async {
    setState(() {
      _message = '';
    });

    try {
      if (_isLogin) {
        _userId = await authentication.login(txtEmail.text, txtPassword.text);
        print('Login for user $_userId');
      } else {
        _userId = await authentication.signUp(txtEmail.text, txtPassword.text);
        print('Sign up for user $_userId');
      }
      if (_userId != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => EventScreen()));
      }
    } catch (error) {
      print('Error: $error');
      setState(() {
        _message = error.toString();
      });
    }
  }

  Widget emailInput() {
    return Padding(
      padding: EdgeInsets.only(top: 120),
      child: TextFormField(
        controller: txtEmail,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'email',
          icon: Icon(Icons.email),
        ),
        validator: (text) => text.isEmpty ? 'Email is required' : '',
      ),
    );
  }

  Widget passwordInput() {
    return Padding(
      padding: EdgeInsets.only(top: 120),
      child: TextFormField(
        controller: txtPassword,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'password',
          icon: Icon(Icons.enhanced_encryption),
        ),
        validator: (text) => text.isEmpty ? 'Password is required' : '',
      ),
    );
  }

  Widget mainButton() {
    String buttonText = _isLogin ? 'Login' : 'Sign up';
    return Padding(
      padding: EdgeInsets.only(top: 120),
      child: Container(
        height: 50,
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Theme.of(context).accentColor,
          elevation: 3,
          child: Text(buttonText),
          onPressed: submit,
        ),
      ),
    );
  }

  Widget secondaryButton() {
    String buttonText = !_isLogin ? 'Login' : 'Sign up';
    return FlatButton(
      onPressed: () {
        setState(() {
          _isLogin = !_isLogin;
        });
      },
      child: Text(buttonText),
    );
  }

  Widget validationMessage() {
    return Text(
      _message,
      style: TextStyle(
        fontSize: 12,
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
              child: Column(
            children: [
              emailInput(),
              passwordInput(),
              mainButton(),
              secondaryButton(),
              validationMessage()
            ],
          )),
        ),
      ),
    );
  }
}
