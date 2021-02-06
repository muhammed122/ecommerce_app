class Product {
  String productId;
  String productName;
  String productPrice;
  String productCategory;
  String productImage;
  String productDesc;
  int productQuantity;

  Product(
      {this.productId,
      this.productName,
      this.productPrice,
      this.productCategory,
      this.productImage,
      this.productDesc,
      this.productQuantity});

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'productName': productName,
        'productImage': productImage,
        'productPrice': productPrice,
        'productCategory': productCategory,
        'productDesc': productDesc,
        'productQuantity': productQuantity,
      };

  static Product fromJson(Map<String, dynamic> map, String id) {
    return Product(
        productId: id,
        productName: map['productName'],
        productImage: map['productImage'],
        productPrice: map['productPrice'],
        productCategory: map['productCategory'],
        productDesc: map['productDesc'],
        productQuantity: map['productQuantity']);
    // return Product(map['productId'], map['productName'], map['productPrice'],
    //     map['productCategory'], map['productImage'],
    //     map['productDesc']);
  }

// fromJson(Map<String,dynamic> map)=>{
//   Product(map[''],
//       productPrice ,
//       productCategory,
//       productImage,
//       productDesc)
//
// };
}
