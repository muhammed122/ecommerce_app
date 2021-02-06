import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_flutter/constants.dart';
import 'package:ecommerce_flutter/helper/widgets.dart';
import 'package:ecommerce_flutter/model/cart_item.dart';
import 'package:ecommerce_flutter/model/product_model.dart';
import 'package:ecommerce_flutter/provider/cart_provider.dart';
import 'package:ecommerce_flutter/services/product_store.dart';
import 'package:ecommerce_flutter/services/user_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItemDesign extends StatefulWidget {
  Product product;
  int quantity;
  final GlobalKey<ScaffoldState> scaffoldKey;

  CartItemDesign({this.product, this.quantity, this.scaffoldKey});

  @override
  _CartItemDesignState createState() => _CartItemDesignState();
}

class _CartItemDesignState extends State<CartItemDesign> {
  final _store = StoreData();

  final _userAuth = UserAuth();

  var provider;

  GlobalKey _scaffold = GlobalKey();

  @override
  Widget build(BuildContext context) {
    if (provider == null) provider = Provider.of<CartProvider>(context);
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(6),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: widget.product.productImage,
                  width: MediaQuery.of(context).size.width / 4,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.product.productName}',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        Text(
                          '${widget.product.productDesc}',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w200,
                              color: Colors.black87),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'EGP ${widget.product.productPrice}',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: Colors.deepOrangeAccent),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Divider(
              height: 1,
              color: Colors.black,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  Builder(
                    builder: (mContext) => GestureDetector(
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete,
                            color: kMainColor,
                          ),
                          Text('REMOVE')
                        ],
                      ),
                      onTap: () {
                        myAlertDialog(context, "Remove Item",
                            "Do you Want Remove this item ..? ", () {
                          removeProduct(mContext);
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          decreaseProduct();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            decoration: BoxDecoration(
                                color: kMainColor, shape: BoxShape.circle),
                            padding: EdgeInsets.all(2),
                            child: Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        '${widget.quantity}',
                        style: TextStyle(fontSize: 20),
                      ),
                      Builder(
                        builder: (context) => GestureDetector(
                          onTap: () {
                            increaseProduct(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Builder(
                              builder: (context) => Container(
                                decoration: BoxDecoration(
                                    color: kMainColor, shape: BoxShape.circle),
                                padding: EdgeInsets.all(2),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  removeProduct(BuildContext context) async {
    try {
      await _store.removeItemFromCart(
          widget.product.productId, _userAuth.getCurrentUser());
      changeCartCount(context, -widget.quantity);
      mySnackBar(context, 'Product Deleted');
    } catch (e) {
      mySnackBar(context, '${e.message}');
    }
  }

  void decreaseProduct() async {
    if (widget.quantity > 1) {
      try {
        setState(() {
          widget.quantity--;
        });
        await _store.editOrderQuantity(widget.product.productId,
            _userAuth.getCurrentUser(), widget.quantity);
      } catch (e) {
        mySnackBar(context, '${e.message}');
        setState(() {
          widget.quantity++;
        });
      }
    }
  }

  changeCartCount(BuildContext context, int count) {
    try {
      int cartCount = provider.cartCount + count;
      print("test test $cartCount");
      provider.updateCartCount(cartCount);
    } catch (e) {
      print("eeeeeeee ${e.message}");
    }
  }

  void increaseProduct(BuildContext context) async {
    if (widget.quantity < widget.product.productQuantity)
      try {
        setState(() {
          widget.quantity++;
        });
        //changeCartCount(context, widget.quantity);
        await _store.editOrderQuantity(widget.product.productId,
            _userAuth.getCurrentUser(), widget.quantity);
      } catch (e) {
        mySnackBar(context, '${e.message}');
        setState(() {
          widget.quantity--;
        });
      }
    else
      showToast(context, "No More Quantity");
  }
}
