import 'package:ecommerce_flutter/constants.dart';
import 'package:ecommerce_flutter/helper/popup_menu.dart';
import 'package:ecommerce_flutter/model/product_model.dart';
import 'package:ecommerce_flutter/services/product_store.dart';
import 'package:ecommerce_flutter/ui/admin/edit_product.dart';
import 'package:ecommerce_flutter/ui/user/product_details.dart';
import 'package:flutter/material.dart';

class ProductItemAdmin extends StatelessWidget {
  final Product product;

  ProductItemAdmin({@required this.product});

  final StoreData _store = StoreData();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(ProductDetails.route, arguments: product);
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Card(
          elevation: 5,
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //     child: Image.asset(
                //   "images/icons/boot.png",
                //   width: MediaQuery.of(context).size.width,
                // )),
                Expanded(
                  child: Image.network(
                    product.productImage,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.productName,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Text(
                        '${product.productPrice} LE',
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                    ],
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        product.productCategory,
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ),
                    GestureDetector(
                        child: Icon(Icons.menu),
                        onTapUp: (details) {
                          double dx = details.globalPosition.dx;
                          double dy = details.globalPosition.dy;
                          double dx1 = MediaQuery.of(context).size.width - dx;
                          double dy1 = MediaQuery.of(context).size.height - dy;

                          showMenu(
                              context: context,
                              position: RelativeRect.fromLTRB(dx, dy, dx1, dy1),
                              items: [
                                MyPopupMenuItem(
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit),
                                      Text('Edit'),
                                    ],
                                  ),
                                  onClick: () {
                                    Navigator.pushNamed(
                                        context, EditProduct.route,
                                        arguments: product);
                                  },
                                ),
                                MyPopupMenuItem(
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete),
                                      Text('Delete'),
                                    ],
                                  ),
                                  onClick: () {
                                    alertDialog(context, "Delete Product",
                                        "Do you want delete this product ?");
                                  },
                                ),
                              ]);
                        })
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  alertDialog(BuildContext context, String title, String content) {
    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        FlatButton(
            onPressed: () async {
              _store.deleteProduct(product.productId);
              Navigator.pop(context);
            },
            child: Text('Yes')),
        FlatButton(
            onPressed: () async {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('Cancel')),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
