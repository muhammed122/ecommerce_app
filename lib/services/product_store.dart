import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_flutter/constants.dart';
import 'package:ecommerce_flutter/model/cart_item.dart';
import 'package:ecommerce_flutter/model/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class StoreData {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  addProduct(Product product) async {
    print("product here ${product.productId}");

    final collRef = _fireStore.collection(kProductCollection);
    final docReference = collRef.doc();
    product.productId = docReference.id;

    print("product ${product.productId}");
    await docReference.set(product.toJson());
  }

  Stream<QuerySnapshot> productStream() =>
      _fireStore.collection(kProductCollection).snapshots();

  Stream<QuerySnapshot> getProductsByCategory(String cate) => _fireStore
      .collection(kProductCollection)
      .where("productCategory", isEqualTo: cate)
      .snapshots();

  Stream<QuerySnapshot> searchByProductOrCategory(String search) {
    if (search != null)
      return _fireStore
          .collection(kProductCollection)
          .where('productName', isEqualTo: search)
          .snapshots();

    return null;
  }

  Future<String> uploadFile(File _image) async {
    String imageUrl;
    var ref = _firebaseStorage
        .ref()
        .child('products/images/')
        .child(path.basename(_image.path));

    UploadTask uploadTask;
    uploadTask = ref.putFile(_image);
    await uploadTask
        .whenComplete(() async => {imageUrl = await ref.getDownloadURL()});

    return imageUrl;
  }

  deleteProduct(String productId) async {
    await _fireStore.collection('products').doc(productId).delete();
  }

  editProduct(Product product) async {
    await _fireStore
        .collection('products')
        .doc(product.productId)
        .update(product.toJson());
  }

  Future<DocumentSnapshot> getProductById(CartItem item) async {
    return await _fireStore
        .collection('products')
        .doc(item.product.productId)
        .get();
  }

  addProductToCart(CartItem item, User user) async {
    await _fireStore
        .collection(kCartCollection)
        .doc(user.uid)
        .collection("items")
        .doc(item.product.productId)
        .set(item.toJson());
  }

  Future<bool> checkProductInCart(CartItem item, User user) async {
    var data = await _fireStore
        .collection(kCartCollection)
        .doc(user.uid)
        .collection("items")
        .doc(item.product.productId)
        .get();
    if (!data.exists || data == null) return false;
    return true;
  }

  Stream<QuerySnapshot> getCartItems(User user) => _fireStore
      .collection(kCartCollection)
      .doc(user.uid)
      .collection("items")
      .snapshots();

  removeItemFromCart(String productId, User user) async {
    await _fireStore
        .collection(kCartCollection)
        .doc(user.uid)
        .collection("items")
        .doc(productId)
        .delete();
  }

  editOrderQuantity(String productId, User user, int quantity) async {
    await _fireStore
        .collection(kCartCollection)
        .doc(user.uid)
        .collection("items")
        .doc(productId)
        .update({"requiredQuantity": quantity});
  }
}
