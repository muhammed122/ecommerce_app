import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_flutter/constants.dart';
import 'package:ecommerce_flutter/helper/widgets.dart';
import 'package:ecommerce_flutter/model/cart_item.dart';
import 'package:ecommerce_flutter/model/product_model.dart';
import 'package:ecommerce_flutter/provider/cart_provider.dart';
import 'package:ecommerce_flutter/provider/modal_hud_provider.dart';
import 'package:ecommerce_flutter/services/product_store.dart';
import 'package:ecommerce_flutter/services/user_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';

class ProductDetails extends StatefulWidget {
  static final String route = 'productDetails';
  final StoreData _store = StoreData();

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Product _product;
  int _quantity = 0;
  ModalHub modal;

  var _userAuth = UserAuth();
  var _store = StoreData();


  changeCartCount(BuildContext context,int count){
   var provider = Provider.of<CartProvider>(context , listen: false);
   int cartCount= provider.cartCount +count;
   provider.updateCartCount(cartCount);
  }

  addProductToCart(BuildContext context) async {
    if (_quantity > 0) {
      modal.changeLoadingState();
      try {
        var item = CartItem(
          product: _product,
          requiredQuantity: _quantity,
        );
        bool check =
            await _store.checkProductInCart(item,
                _userAuth.getCurrentUser());
        if (check) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Product Already in your Cart'),
          ));
        } else {
          changeCartCount(context, _quantity);
          await _store.addProductToCart(item, _userAuth.getCurrentUser());
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Product Added to Cart'),
          ));
        }
      } catch (e) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('${e.message}'),
        ));
      }
      modal.changeLoadingState();
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("please select quantity you need "),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_product == null) {
      _product = ModalRoute.of(context).settings.arguments;
    }
    double d = MediaQuery.of(context).size.width * 0.4;
    modal = Provider.of<ModalHub>(context);
    return ModalProgressHUD(
      inAsyncCall: modal.isLoading,
      child: SafeArea(
        child: Scaffold(
          appBar: mainAppbar(context,_product.productName),
          backgroundColor: kDetailsColor,
          body: Column(children: [
            Expanded(
              flex: 8,
              child: Container(
                //  height: MediaQuery.of(context).size.height * 0.7,
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.01),
                child: ListView(
                  children: [
                    Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.white,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: CachedNetworkImage(
                            imageUrl: _product.productImage,
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: MediaQuery.of(context).size.width,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          // child: Image.network(
                          //   _product.productImage,
                          //   height: MediaQuery.of(context).size.height * 0.4,
                          //   width: MediaQuery.of(context).size.width,
                          //   fit: BoxFit.fill,
                          // ),
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Container(
                      color: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _product.productName,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontFamily: fontName),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            '${_product.productDesc}',
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${_product.productPrice} LE',
                            style: TextStyle(
                                color: kMainColor,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Container(
                      padding: EdgeInsets.all(15),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Builder(
                              builder: (context) => Container(
                                decoration: BoxDecoration(
                                    color: kMainColor, shape: BoxShape.circle),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    addProduct(context);
                                  },
                                ),
                              ),
                            ),
                          ),
                          Text(
                            '$_quantity',
                            style: TextStyle(fontSize: 30),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Builder(
                              builder: (context) => Container(
                                decoration: BoxDecoration(
                                    color: kMainColor, shape: BoxShape.circle),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.remove,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    removeProduct();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Builder(
                      builder: (context) => RaisedButton(
                          color: kMainColor,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    Icons.add_shopping_cart,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 100),
                                    child: Text(
                                      'Add to Cart',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              )),
                          onPressed: () {
                            addProductToCart(context);
                          }),
                    )),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void removeProduct() {
    if (_quantity > 0)
      setState(() {
        _quantity--;
      });
  }

  void addProduct(BuildContext context) {
    if (_quantity < _product.productQuantity)
      setState(() {
        _quantity++;
      });
    else
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("No more quantity "),
      ));
  }
}
