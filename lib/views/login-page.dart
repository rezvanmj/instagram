import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/controllers/user-controller.dart';
import 'package:instagram/views/instagram-body.dart';
import 'package:instagram/views/sign-up.dart';
import 'package:instagram/views/widgets/simple-appbar.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => UserController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _loginBody(),
    );
  }

  void _navigate() {
    if (_userController.isAuth()) {
      Get.offAll(() => InstagramBody());
    } else {
      Get.snackbar('invalid username or password', 'please try again');
    }
  }

  void _validate() {
    // await _userController.getUserData();
    if (_formKey.currentState.validate()) {
      _authenticate();
    } else {
      Get.snackbar('invalid information', 'please try again');
    }
  }

  void _authenticate() async {
    await _userController.authenticate(
        usernameController.text, passwordController.text);
    _navigate();
  }

  PreferredSize _appBar() => PreferredSize(
      child: SimpleAppBar('Login', true),
      preferredSize: const Size.fromHeight(60));

  Widget _userNameField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        validator: (value) => value.isEmpty ? "fill this field" : null,
        controller: usernameController,
        decoration: InputDecoration(
            icon: Icon(Icons.person),
            labelText: "username",
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blueGrey))),
      ),
    );
  }

  Widget _passwordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextFormField(
        validator: (value) => value.isEmpty ? "fill this field" : null,
        obscureText: !_showPassword,
        controller: passwordController,
        decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _showPassword = !_showPassword;
                  });
                },
                icon: !_showPassword
                    ? Icon(Icons.remove_red_eye)
                    : Icon(Icons.visibility_off)),
            labelText: "password",
            icon: Icon(Icons.password),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey),
            )),
      ),
    );
  }

  Widget _textButton() {
    return TextButton(
        onPressed: () => Get.offAll(() => SignUpPage()),
        child: Text("i dont have an account",
            style: TextStyle(color: Colors.blueGrey)));
  }

  Widget _loginButton() {
    return OutlineButton(
      onPressed: () => _validate(),
      child: Text("Login"),
      color: Colors.blueGrey,
      splashColor: Colors.blueGrey,
      focusColor: Colors.blueGrey,
      textColor: Colors.black,
      borderSide: BorderSide(color: Colors.blueGrey),
    );
  }

  Widget _loginBody() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _userNameField(),
          SizedBox(
            height: 20.0,
          ),
          _passwordField(),
          SizedBox(
            height: 20.0,
          ),
          _textButton(),
          SizedBox(
            height: 20.0,
          ),
          _loginButton()
        ],
      ),
    );
  }

  UserController get _userController {
    return Get.find<UserController>();
  }
}
