import 'package:ecommerce_flutter/constants.dart';
import 'package:ecommerce_flutter/helper/widgets.dart';
import 'package:ecommerce_flutter/ui/admin/add_product.dart';
import 'package:ecommerce_flutter/ui/admin/manage_product.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  static final String route = 'adminScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, AddProductScreen.route);
              },
              child: Text("Add Product"),
            ),
            RaisedButton(
              onPressed: () {
               Navigator.pushNamed(context, ManageProduct.route);
              },
              child: Text("Edit Product"),
            ),
            RaisedButton(
              onPressed: () {},
              child: Text("View Product"),
            )
          ],
        ),
      ),
    );
  }
}
