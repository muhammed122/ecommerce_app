import 'package:ecommerce_flutter/constants.dart';
import 'package:ecommerce_flutter/helper/shared_prefrence.dart';
import 'package:ecommerce_flutter/ui/login_screen.dart';
import 'package:ecommerce_flutter/ui/user/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatefulWidget {
  static final String route = 'splashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  checkUserLogin() async {
    await Future.delayed(Duration(seconds: 3));
    var login = await SharedPreferenceHelper.checkUserLogin();
    if (login)
      Navigator.pushReplacementNamed(context, BaseScreen.route);
    else
      Navigator.pushReplacementNamed(context, LoginScreen.route);
  }

  @override
  void initState()  {

    checkUserLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: kMainColor,
      height: screenHeight,
      width: screenWidth,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_shopping_cart_outlined,
              size: 150,
              color: Colors.white,
            ),
            Container(
              height: screenHeight * 0.3,
              child: ScaleAnimatedTextKit(
                duration: Duration(seconds: 2),
                text: [
                  "BUY",
                  "IT",
                ],
                textStyle: TextStyle(
                    fontSize: 70.0, fontFamily: fontName, color: Colors.white),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
