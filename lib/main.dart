import 'package:ecommerce_flutter/constants.dart';
import 'package:ecommerce_flutter/helper/shared_prefrence.dart';
import 'package:ecommerce_flutter/provider/admin_provider.dart';
import 'package:ecommerce_flutter/provider/cart_provider.dart';
import 'package:ecommerce_flutter/provider/image_provider.dart';
import 'package:ecommerce_flutter/provider/modal_hud_provider.dart';
import 'package:ecommerce_flutter/ui/admin/add_product.dart';
import 'package:ecommerce_flutter/ui/admin/admin_screen.dart';
import 'package:ecommerce_flutter/ui/admin/edit_product.dart';
import 'package:ecommerce_flutter/ui/admin/manage_product.dart';
import 'package:ecommerce_flutter/ui/login_screen.dart';
import 'package:ecommerce_flutter/ui/signup_screen.dart';
import 'package:ecommerce_flutter/ui/splash_screen.dart';
import 'package:ecommerce_flutter/ui/user/base_screen.dart';
import 'package:ecommerce_flutter/ui/user/cart_screen.dart';
import 'package:ecommerce_flutter/ui/user/home_screen.dart';
import 'package:ecommerce_flutter/ui/user/product_details.dart';
import 'package:ecommerce_flutter/ui/user/profile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  bool _isLogin = false;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModalHub>(
          create: (context) => ModalHub(),
        ),
        ChangeNotifierProvider<AdminMode>(
          create: (context) => AdminMode(),
        ),
        ChangeNotifierProvider<MyImageProvider>(
          create: (context) => MyImageProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowMaterialGrid: false,
        debugShowCheckedModeBanner: false,
        title: 'Buy It',
        initialRoute: SplashScreen.route,
        routes: {
          SplashScreen.route: (context) => SplashScreen(),
          LoginScreen.route: (context) => LoginScreen(),
          SignUpScreen.route: (context) => SignUpScreen(),
          HomeScreen.route: (context) => HomeScreen(),
          AdminScreen.route: (context) => AdminScreen(),
          AddProductScreen.route: (context) => AddProductScreen(),
          ManageProduct.route: (context) => ManageProduct(),
          EditProduct.route: (context) => EditProduct(),
          ProductDetails.route: (context) => ProductDetails(),
          UserProfile.route: (context) => UserProfile(),
          CartScreen.route: (context) => CartScreen(),
          BaseScreen.route: (context) => BaseScreen()
        },
      ),
    );
  }
}
