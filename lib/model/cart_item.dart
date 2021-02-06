import 'package:ecommerce_flutter/model/product_model.dart';

class CartItem {
  Product product;
  int requiredQuantity;

  CartItem({this.product, this.requiredQuantity});

  Map<String, dynamic> toJson() => {
        "product": product.toJson(),
        "requiredQuantity": requiredQuantity,
      };

  static CartItem fromJson(Map<String, dynamic> map ,  id ) {
    return CartItem(
        product:Product.fromJson(map["product"],id),
        requiredQuantity: map["requiredQuantity"]);
  }
}
