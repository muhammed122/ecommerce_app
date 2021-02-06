import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_flutter/helper/product_item_user.dart';
import 'package:ecommerce_flutter/model/product_model.dart';
import 'package:ecommerce_flutter/services/product_store.dart';
import 'package:flutter/material.dart';

class ProductTap extends StatelessWidget {
  String category;

  ProductTap({this.category});

  var _store = StoreData();
  List<Product> products = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: _store.getProductsByCategory(category),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              products.clear();
              for (var doc in snapshot.data.docs)
                products.add(Product.fromJson(doc.data(), doc.id));
              return products.length == 0
                  ? Center(
                      child: Text("No items to show"),
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductItemUser(
                          product: products[index],
                        );
                      });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
