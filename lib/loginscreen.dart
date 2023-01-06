//import 'package:homestay_raya_ass2/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homestay_raya_ass2/registrationscreen.dart';
import 'views/config.dart';
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  //bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  var screenHeight, screenWidth, cardWidth;

  get http => null;
  get _loginUser => null;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      cardWidth = screenWidth;
    } else {
      cardWidth = 400.00;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
          child: SingleChildScrollView(
        child: SizedBox(
          width: cardWidth,
          child: Card(
            elevation: 8,
            margin: const EdgeInsets.all(8),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                        controller: _emailEditingController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (val) => val!.isEmpty ||
                                !val.contains("@") ||
                                !val.contains(".")
                            ? "Enter a valid email address"
                            : null,
                        decoration: const InputDecoration(
                            labelText: 'Email address',
                            labelStyle: TextStyle(),
                            icon: Icon(Icons.email),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.0),
                            ))),
                    TextFormField(
                        controller: _passEditingController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(),
                          icon: Icon(Icons.password),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1.0),
                          ),
                        )),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked = value!;
                              saveremoveprof(value);
                            });
                          },
                        ),
                        Flexible(
                          child: GestureDetector(
                            onTap: null,
                            child: const Text('Remember Me',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          minWidth: 115,
                          height: 50,
                          elevation: 10,
                          onPressed: _loginUser,
                          color: Theme.of(context).colorScheme.primary,
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: _goLogin,
                      child: const Text(
                        "Dont have an account. Register now",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: _goHome,
                      child: const Text("Go back Home",
                          style: TextStyle(fontSize: 18)),
                    )
                  ],
                )),
          ),
        ),
      )),
    );
  }

  void_loginUser() {
    if (!_formKey.currentState!.validate()) {
      if (!_formKey.currentState!.validate()) {
        Fluttertoast.showToast(
            msg: "Please fill in the login credentials",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        return;
      }
      http.post(Uri.parse("${Config.SERVER}/php/login_user.php"),
          body: {"email:", "password:"}).then((response) {
        print(response.body);
      });
    }
  }

  void _goHome() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const RegistrationScreen()));
  }

  void _goLogin() {
    Navigator.push(context,
        MaterialPageRoute(builder: ((context) => const RegistrationScreen())));
  }

  void saveremoveprof(bool value) async {
    String email = _emailEditingController.text;
    String password = _passEditingController.text;
    var SharedPreferences;
    var prefs = await SharedPreferences.getInstance();
    if (value) {
      if (!_formKey.currentState!.validate()) {
        Fluttertoast.showToast(
            msg: "Please fill in the login credentials",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        _isChecked = false;
        return;
      }
      await prefs.setString('email', email);
      await prefs.setString('pass', password);
      Fluttertoast.showToast(
          msg: "Preference Stored",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
    } else {
      await prefs.setString('email', '');
      await prefs.setString('pass', '');
      setState(() {
        _emailEditingController.text = '';
        _passEditingController.text = '';
        _isChecked = false;
      });
      Fluttertoast.showToast(
          msg: "Preference Removed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
    }
  }
}
