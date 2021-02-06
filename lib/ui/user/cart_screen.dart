import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_flutter/constants.dart';
import 'package:ecommerce_flutter/helper/cart_item_user.dart';
import 'package:ecommerce_flutter/model/cart_item.dart';
import 'package:ecommerce_flutter/services/product_store.dart';
import 'package:ecommerce_flutter/services/user_auth.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  static final String route = "cartScreen";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var _store = StoreData();
  var _userAuth = UserAuth();
  List<CartItem> items = [];
  double subTotal = 0;
  double total = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  getAllItems() async {
    var stream = _store.getCartItems(_userAuth.getCurrentUser());
    if (!await stream.isEmpty) {
      await stream.forEach((field) {
        field.docs.asMap().forEach((index, data) {
          print("product ${data.data()}");
          items.add(CartItem.fromJson(data.data(), field.docs[index].id));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: kMainColor,
          title: Text(
            'Cart',
            style: TextStyle(color: Colors.white, fontFamily: fontName),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: _store.getCartItems(_userAuth.getCurrentUser()),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        items.clear();
                        subTotal = 0;
                        total = 0;
                        for (var doc in snapshot.data.docs) {
                          var item = CartItem.fromJson(doc.data(), doc.id);
                          items.add(item);
                          subTotal += double.parse(item.product.productPrice) *
                              item.requiredQuantity;
                        }
                        return items.length == 0
                            ? Center(
                                child: Text('No Data to show'),
                              )
                            : Column(
                                children: [
                                  Expanded(
                                    child: ListView.builder(
                                        itemCount: items.length,
                                        itemBuilder: (context, index) {
                                          return CartItemDesign(
                                            product: items[index].product,
                                            quantity:
                                                items[index].requiredQuantity,
                                            scaffoldKey: _scaffoldKey,
                                          );
                                        }),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 15),
                                    child: Column(
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 7,
                                                child: Text(
                                                  'Subtotal',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  '$subTotal EGP',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 7,
                                                child: Text(
                                                  'Shipping',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  '50 EGP',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Divider(
                                          height: 1,
                                          color: Colors.black38,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 7,
                                                child: Text(
                                                  'Total',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  '${subTotal + 50} EGP',
                                                  style: TextStyle(
                                                      color: Colors
                                                          .deepOrangeAccent,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        SizedBox(
                                          child: RaisedButton(
                                            onPressed: () {},
                                            child: Container(
                                              child: Text(
                                                'COMPLETE YOUR ORDER',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 15),
                                            ),
                                            color: kMainColor,
                                          ),
                                          width: double.infinity,
                                        ),
                                        SizedBox(
                                          child: RaisedButton(
                                            onPressed: () {},
                                            child: Container(
                                              child: Row(
                                                children: [
                                                  Icon(Icons.call),
                                                  Text(
                                                    'CALL TO ORDER',
                                                    style: TextStyle(
                                                      color: kMainColor,
                                                    ),
                                                  ),
                                                ],
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10),
                                            ),
                                            color: Colors.white,
                                          ),
                                          width: double.infinity,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
