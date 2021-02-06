import 'dart:io';

import 'package:ecommerce_flutter/constants.dart';
import 'package:ecommerce_flutter/model/product_model.dart';
import 'package:ecommerce_flutter/provider/image_provider.dart';
import 'package:ecommerce_flutter/provider/modal_hud_provider.dart';
import 'package:ecommerce_flutter/services/product_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_flutter/helper/widgets.dart';
import 'package:ecommerce_flutter/provider/image_provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatelessWidget {
  static final String route = 'addProduct';
  MyImageProvider imageProvider;
  final GlobalKey<FormState> _key = GlobalKey();
  final _store = StoreData();

  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productCategoryController = TextEditingController();
  TextEditingController _productPriceController = TextEditingController();
  TextEditingController _productImageController = TextEditingController();
  TextEditingController _productDescriptionController = TextEditingController();
  TextEditingController _productQuantityController = TextEditingController();

  ModalHub _modalHub;

  @override
  Widget build(BuildContext context) {
    imageProvider = Provider.of<MyImageProvider>(context);
    return Scaffold(
      backgroundColor: kMainColor,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHub>(context).isLoading,
        child: ListView(
          children: [
            Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  productTextField("Product Name", _productNameController,
                      TextInputType.name),
                  productTextField("Product price In ELD",
                      _productPriceController, TextInputType.number),
                  productTextField(
                    "Product Category",
                    _productCategoryController,
                    TextInputType.name,
                  ),
                  productTextField("Product Description",
                      _productDescriptionController, TextInputType.multiline),
                  productTextField("Product Quantity",
                      _productQuantityController, TextInputType.number),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: productTextField("Product Image path",
                              _productImageController, TextInputType.url),
                        ),
                        RaisedButton(
                          onPressed: () async {
                            await imageProvider.getImage();
                            if (imageProvider.imageFile != null)
                              _productImageController.text =
                                  imageProvider.imageFile.path;
                          },
                          child: Text('add image'),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: imageProvider.imageFile != null
                        ? Image.file(
                            imageProvider.imageFile,
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.2,
                          )
                        : Center(
                            child: Text(
                              'No image to show',
                              style: TextStyle(color: Colors.white54),
                            ),
                          ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.1,
                  horizontal: MediaQuery.of(context).size.width * 0.2),
              child: Builder(
                builder: (context) => RaisedButton(
                    onPressed: () {
                      uploadProduct(context);
                    },
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      "Upload Product",
                      style: TextStyle(
                        fontFamily: fontName,
                        fontSize: 20,
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> uploadProduct(BuildContext context) async {
    final modal = Provider.of<ModalHub>(context, listen: false);
    modal.changeLoadingState();
    if (_key.currentState.validate()) {
      try {
        String image = await _store.uploadFile(imageProvider.imageFile);
        await _store.addProduct(Product(
          productName: _productNameController.value.text.trim(),
          productPrice: _productPriceController.value.text.trim(),
          productCategory: _productCategoryController.value.text.trim(),
          productImage: image,
          productDesc: _productDescriptionController.value.text.trim(),
          productQuantity:int.parse(_productQuantityController.value.text.trim()),
        ));

        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("Product Uploaded")));
        _key.currentState.reset();
      } catch (e) {

        print("errror here $e");
        // Scaffold.of(context)
        //     .showSnackBar(SnackBar(content: Text("${e.message}")));
      }
    }
    modal.changeLoadingState();
  }
}
