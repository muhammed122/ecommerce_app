import 'package:badges/badges.dart';
import 'package:ecommerce_flutter/constants.dart';
import 'package:ecommerce_flutter/helper/widgets.dart';
import 'package:ecommerce_flutter/provider/cart_provider.dart';
import 'package:ecommerce_flutter/ui/user/cart_screen.dart';
import 'package:ecommerce_flutter/ui/user/product_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static String route = "homeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _cartCount;

  @override
  void initState() {
    // getCartCount();
    super.initState();
  }

  getCartCount() async {
    await Provider.of<CartProvider>(context).getCartCount();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: kMainColor,
              title: Text(
                'Home',
                style: TextStyle(color: Colors.white, fontFamily: fontName),
              ),
              actions: [
                cartIcon(context, Provider.of<CartProvider>(context).cartCount),
              ],
              bottom: TabBar(
                  unselectedLabelColor: Colors.white54,
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(text: 'Clothes'),
                    Tab(text: 'Shoes',),
                    Tab(text: 'Electronics'),
                    Tab(text: 'Car'),
                  ]),
            ),
            body: TabBarView(children: [
              ProductTap(
                category: kClothes,
              ),
              ProductTap(
                category: kShoes,
              ),
              ProductTap(
                category: kMobile,
              ),
              ProductTap(
                category: kCar,
              )
            ]),
          ),
        )
      ],
    );
  }
}
