import 'package:ecommerce_flutter/helper/widgets.dart';
import 'package:ecommerce_flutter/model/user_model.dart';
import 'package:ecommerce_flutter/provider/modal_hud_provider.dart';
import 'package:ecommerce_flutter/services/user_auth.dart';
import 'package:ecommerce_flutter/ui/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class SignUpScreen extends StatelessWidget {
  static final String route = "SignUpScreen";
  TextEditingController _userName = TextEditingController();
  TextEditingController _userEmail = TextEditingController();
  TextEditingController _userPassword = TextEditingController();
  TextEditingController _userPhone = TextEditingController();
  GlobalKey<FormState> _globalKey = GlobalKey();
  UserAuth _userAuth = UserAuth();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    var relativeHeight = MediaQuery.of(context).size.height * 0.5;
    return ModalProgressHUD(
      inAsyncCall: Provider.of<ModalHub>(context).isLoading,
      child: Scaffold(
        backgroundColor: kMainColor,
        body: ListView(children: [
          logoWidget(context),
          Form(
            key: _globalKey,
            child: Column(
              children: [
                customTextField("Enter your Name", Icons.person, _userName,
                    TextInputType.name),
                customTextField("Enter your email", Icons.email, _userEmail,
                    TextInputType.emailAddress),
                customTextField("Enter your Password", Icons.lock,
                    _userPassword, TextInputType.visiblePassword),
                customTextField("Enter your Phone", Icons.phone_android,
                    _userPhone, TextInputType.phone),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: Colors.white),
            child: Builder(
              builder: (context) => FlatButton(
                onPressed: () async {
                  Provider.of<ModalHub>(context, listen: false)
                      .changeLoadingState();
                  if (_globalKey.currentState.validate()) {
                    try {
                      UserCredential result = await _userAuth.signUp(
                          _userEmail.text.trim(), _userPassword.text.trim());

                      await _userAuth.uploadUserData(UserModel(
                        userId: result.user.uid,
                        userEmail: _userEmail.text.trim(),
                        userPhone: _userPhone.text.trim(),
                        userName: _userName.text.trim(),
                      ));
                    } catch (e) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("${e.message}"),
                        duration: Duration(seconds: 2),
                      ));
                    }
                  }
                  Provider.of<ModalHub>(context, listen: false)
                      .changeLoadingState();
                },
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "Sign Up",
                  style: TextStyle(fontFamily: 'pacifico', fontSize: 25),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have account ? ",
                style: TextStyle(color: Color(0xFF4B4754), fontSize: 18),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(context, LoginScreen.route);
                },
                child: Text(
                  "Sing In",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
        ]),
      ),
    );
  }
}
