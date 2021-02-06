import 'package:ecommerce_flutter/helper/widgets.dart';
import 'package:ecommerce_flutter/model/product_model.dart';
import 'package:ecommerce_flutter/provider/image_provider.dart';
import 'package:ecommerce_flutter/provider/modal_hud_provider.dart';
import 'package:ecommerce_flutter/services/product_store.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

class EditProduct extends StatelessWidget {
  static final String route = 'editProduct';

  MyImageProvider imageProvider;
  final GlobalKey<FormState> _key = GlobalKey();
  final _store = StoreData();
  TextEditingController _productNameController = TextEditingController();
  TextEditingController _productCategoryController = TextEditingController();
  TextEditingController _productPriceController = TextEditingController();
  TextEditingController _productImageController = TextEditingController();
  TextEditingController _productDescriptionController = TextEditingController();

  ModalHub _modalHub;
  Product product;

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      product = ModalRoute.of(context).settings.arguments;
      _productNameController.text = product.productName;
      _productPriceController.text = product.productPrice;
      _productCategoryController.text = product.productCategory;
      _productImageController.text = product.productImage;
      _productDescriptionController.text = product.productDesc;
    }

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
                  productTextField("Product price In LE",
                      _productPriceController, TextInputType.number),
                  productTextField("Product Category",
                      _productCategoryController, TextInputType.name),
                  productTextField("Product Description",
                      _productDescriptionController, TextInputType.multiline),
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
                            // await imageProvider.getImage();
                            // if (imageProvider.imageFile != null)
                            //   _productImageController.text =
                            //       imageProvider.imageFile.path;
                          },
                          child: Text('change image'),
                        )
                      ],
                    ),
                  ),
                  // Container(
                  //   child: imageProvider.imageFile != null
                  //       ? Image.file(
                  //           imageProvider.imageFile,
                  //           width: MediaQuery.of(context).size.width * 0.3,
                  //           height: MediaQuery.of(context).size.height * 0.2,
                  //         )
                  //       : Center(
                  //           child: Text(
                  //             'No image to show',
                  //             style: TextStyle(color: Colors.white54),
                  //           ),
                  //         ),
                  // )
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
                      editProduct(context);
                    },
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      "Edit Product",
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

  Future<dynamic> editProduct(BuildContext context) async {
    final modal = Provider.of<ModalHub>(context, listen: false);
    modal.changeLoadingState();

    if (_key.currentState.validate()) {
      try {
        await _store.editProduct(Product(
          productId: product.productId,
          productName: _productNameController.value.text.trim(),
          productPrice: _productPriceController.value.text.trim(),
          productCategory: _productCategoryController.value.text.trim(),
          productImage: _productImageController.value.text.trim(),
          productDesc: _productDescriptionController.value.text.trim(),
        ));

        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("Product Edited")));
        _key.currentState.reset();
      } catch (e) {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text("${e.message}")));
      }
    }
    modal.changeLoadingState();
  }
}
