import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_flutter/helper/shared_prefrence.dart';
import 'package:ecommerce_flutter/model/cart_item.dart';
import 'package:ecommerce_flutter/services/product_store.dart';
import 'package:ecommerce_flutter/services/user_auth.dart';
import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier {
  int cartCount = 0;

  getCartCount() async {
    cartCount = await SharedPreferenceHelper.getCartCount();
    notifyListeners();
  }

  updateCartCount(int count) async {
    cartCount = count;
    await SharedPreferenceHelper.saveCartCount(count);
    print("count count ttttttt $cartCount");
    notifyListeners();
  }
}
