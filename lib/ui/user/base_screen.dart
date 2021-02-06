import 'package:ecommerce_flutter/helper/shared_prefrence.dart';
import 'package:ecommerce_flutter/provider/cart_provider.dart';
import 'package:ecommerce_flutter/ui/user/cart_screen.dart';
import 'package:ecommerce_flutter/ui/user/home_screen.dart';
import 'package:ecommerce_flutter/ui/user/profile_screen.dart';
import 'package:ecommerce_flutter/ui/user/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class BaseScreen extends StatefulWidget {
  static final String route = "baseScreen";

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _currentTab = 0;

  final tabs = [HomeScreen(), SearchScreen(), UserProfile(), CartScreen()];

  int _cartCount ;

  getCartCount(BuildContext context) async {
    await Provider.of<CartProvider>(context).getCartCount();
    _cartCount = Provider.of<CartProvider>(context, listen: false).cartCount;
  }

  @override
  Widget build(BuildContext context) {
    if (_cartCount == null) {
      getCartCount(context);
    }

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.black));
    return Scaffold(
      body: tabs[_currentTab],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: kMainColor,
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: Colors.white,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: TextStyle(color: Colors.white54))),
        // sets the inactive color of the `BottomNavigationBar`
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentTab,
          onTap: (index) {
            setState(() {
              _currentTab = index;
            });
          },
          items: [
            BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
            BottomNavigationBarItem(label: 'Search', icon: Icon(Icons.search)),
            BottomNavigationBarItem(label: 'Profile', icon: Icon(Icons.person)),
            BottomNavigationBarItem(
                label: 'Logout', icon: Icon(Icons.exit_to_app)),
          ],
        ),
      ),
    );
  }
}
