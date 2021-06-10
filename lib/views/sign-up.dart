import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagram/controllers/user-controller.dart';
import 'package:instagram/models/user-model.dart';
import 'package:instagram/views/instagram-body.dart';
import 'package:instagram/views/login-page.dart';
import 'package:instagram/views/widgets/simple-appbar.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => UserController());

    return Scaffold(appBar: _appBar(), body: _signUpBody());
  }

  Widget _appBar() {
    return PreferredSize(
        child: SimpleAppBar('SignUp', true),
        preferredSize: const Size.fromHeight(60));
  }

  Widget _signUpBody() {
    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          _profilePicture(),
          SizedBox(
            height: 30,
          ),
          _inputTextField(usernameController, 'username'),
          SizedBox(
            height: 20,
          ),
          _inputTextField(passwordController, 'password'),
          SizedBox(
            height: 20,
          ),
          _inputTextField(emailController, 'Email'),
          SizedBox(
            height: 40,
          ),
          _textButton(),
          _button(),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  void _checkUsername() {
    _userController.checkUsername(usernameController.text);
    if (!_userController.isSameUsername()) {
      _addUser();
    } else {
      Get.snackbar('this username already exists', 'enter new username');
    }
  }

  void _addUser() async {
    UserModel newUser = UserModel(
        username: usernameController.text,
        password: passwordController.text,
        email: emailController.text,
        imageUrl:
            'https://d2lo9qrcc42lm4.cloudfront.net/Images/News/_contentLarge/Main-girls-out-of-school.jpg?mtime=20170426205135');
    await _userController.addUser(newUser);
    _userController.mainPageFlag(true);
    Get.off(() => InstagramBody());
  }

  void _validation() {
    if (_formKey.currentState.validate()) {
      _checkUsername();
    } else {
      Get.snackbar('something went wrong', 'please try again');
    }
  }

  Widget _button() {
    return OutlineButton(
      onPressed: () async {
        _validation();
      },
      child: Text("sign Up"),
      color: Colors.blueGrey,
      splashColor: Colors.blueGrey,
      focusColor: Colors.blueGrey,
      textColor: Colors.black,
      borderSide: BorderSide(color: Colors.blueGrey),
    );
  }

  Widget _textButton() {
    return TextButton(
        onPressed: () {
          Get.offAll(() => LoginPage());
        },
        child: Text(
          'i have account',
          style: TextStyle(color: Colors.blueGrey),
        ));
  }

  Widget _inputTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        controller: controller,
        validator: (value) => value.isEmpty ? "field cant be empty" : null,
        decoration: InputDecoration(
          labelText: label,
        ),
      ),
    );
  }

  Widget _profilePicture() {
    return Center(
      child: Container(
        width: 220,
        child: Stack(children: [_profileAvatar(), _profileAddPictureIcon()]),
      ),
    );
  }

  Widget _profileAddPictureIcon() {
    return Container(
      height: 120.0,
      width: 100.0,
      child: Center(
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
              backgroundColor: Colors.black,
              child: new Icon(Icons.camera_alt),
              onPressed: () {}),
        ),
      ),
    );
  }

  Widget _profileAvatar() {
    return Center(
        child: CircleAvatar(
      foregroundColor: Colors.black,
      backgroundColor: Colors.blueGrey,
      radius: 50,
      child: Icon(
        Icons.person,
        size: 30,
      ),
    ));
  }

  UserController get _userController {
    return Get.find<UserController>();
  }
}
