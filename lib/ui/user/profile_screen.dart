import 'package:ecommerce_flutter/constants.dart';
import 'package:ecommerce_flutter/helper/widgets.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  static final String route = "userProfile";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: kMainColor,
      appBar: mainAppbar(context, 'Profile'),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: kMainColor, width: 0.5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                userInfoItem("Name", "Mohammed Adel"),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                  child: Divider(
                    color: Colors.black54,
                  ),
                ),
                userInfoItem("Email Address", "Madel@gmail.com"),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                  child: Divider(
                    color: Colors.black54,
                  ),
                ),
                userInfoItem("Contact Number", "01121308294"),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                  child: Divider(
                    color: Colors.black54,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
