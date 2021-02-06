import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_flutter/constants.dart';
import 'package:ecommerce_flutter/helper/popup_menu.dart';
import 'package:ecommerce_flutter/model/product_model.dart';
import 'package:ecommerce_flutter/services/product_store.dart';
import 'package:ecommerce_flutter/ui/user/product_details.dart';
import 'package:flutter/material.dart';

class ProductItemUser extends StatelessWidget {
  final Product product;
  ProductItemUser({@required this.product});
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
                  child: CachedNetworkImage(
                    imageUrl: product.productImage,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
