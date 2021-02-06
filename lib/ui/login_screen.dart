import 'package:ecommerce_flutter/helper/shared_prefrence.dart';
import 'package:ecommerce_flutter/helper/widgets.dart';
import 'package:ecommerce_flutter/provider/admin_provider.dart';
import 'package:ecommerce_flutter/provider/modal_hud_provider.dart';
import 'package:ecommerce_flutter/services/user_auth.dart';
import 'package:ecommerce_flutter/ui/admin/admin_screen.dart';
import 'package:ecommerce_flutter/ui/signup_screen.dart';
import 'package:ecommerce_flutter/ui/user/base_screen.dart';
import 'package:ecommerce_flutter/ui/user/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class LoginScreen extends StatefulWidget {
  static final String route = "LoginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _globalKey = GlobalKey();
  TextEditingController _userEmail = TextEditingController();
  TextEditingController _userPassword = TextEditingController();
  UserAuth _userAuth = UserAuth();
  AdminMode adminMode;
  bool _rememberMe = false;

  checkUserLogin(BuildContext context) async {
    _rememberMe = await SharedPreferenceHelper.checkUserLogin();
    print("data $_rememberMe");
    if (_rememberMe) {
      Navigator.pushNamed(context, HomeScreen.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    adminMode = Provider.of<AdminMode>(context);
    //checkUserLogin(context);
    return Scaffold(
      backgroundColor: kMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHub>(context).isLoading,
        child: ListView(children: [
          logoWidget(context),
          Form(
            key: _globalKey,
            child: Column(
              children: [
                customTextField("Enter your email", Icons.email, _userEmail,
                    TextInputType.emailAddress),
                customTextField("Enter your Password", Icons.lock,
                    _userPassword, TextInputType.visiblePassword),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Row(
                    children: [
                      Checkbox(
                          checkColor: Colors.black,
                          activeColor: Colors.white,
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value;
                            });
                          }),
                      Text(
                        'Remember Me',
                        style: TextStyle(fontSize: 14, color: Colors.white54),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Radio(
                              activeColor: Colors.white,
                              value: true,
                              groupValue: adminMode.isAdmin,
                              onChanged: (value) {
                                adminMode.changeAdminState();
                                print("admin ${adminMode.isAdmin}");
                              }),
                          Text(
                            ' Admin',
                            style: TextStyle(
                                color: adminMode.isAdmin
                                    ? Colors.white
                                    : Colors.white54),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio(
                            activeColor: Colors.white,
                            value: false,
                            groupValue: adminMode.isAdmin,
                            onChanged: (value) {
                              adminMode.changeAdminState();
                              print("admin ${adminMode.isAdmin}");
                            }),
                        Text(
                          ' User',
                          style: TextStyle(
                              color: adminMode.isAdmin
                                  ? Colors.white54
                                  : Colors.white),
                        )
                      ],
                    )),
                  ],
                ),
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
                      onPressed: () {
                        _validateLogin(context);
                      },
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        "Log in",
                        style: TextStyle(fontFamily: fontName, fontSize: 25),
                      ),
                    )),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have account ? ",
                style: TextStyle(color: Color(0xFF4B4754), fontSize: 18),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, SignUpScreen.route);
                },
                child: Text(
                  "Sing up",
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

  void _validateLogin(BuildContext context) async {
    final modalHub = Provider.of<ModalHub>(context, listen: false);
    modalHub.changeLoadingState();

    bool admin = adminMode.isAdmin;
    if (_globalKey.currentState.validate()) {
      try {
        var user = await _userAuth.signIn(
            _userEmail.text.trim(), _userPassword.text.trim());

        //save user id in shared
        if (_rememberMe) {
          SharedPreferenceHelper.saveUserInfo(_rememberMe, user.user.uid);
        }

        if (admin) if (_userPassword.text.trim() == "admin123") {
          Navigator.pushReplacementNamed(context, AdminScreen.route);
        } else
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text("Check admin password")));
        else
          Navigator.pushReplacementNamed(context, BaseScreen.route);
      } catch (e) {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("${e.message}")));
      }
    }
    modalHub.changeLoadingState();
  }
}
