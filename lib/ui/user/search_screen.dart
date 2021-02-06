import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_flutter/constants.dart';
import 'package:ecommerce_flutter/helper/product_item_user.dart';
import 'package:ecommerce_flutter/model/product_model.dart';
import 'package:ecommerce_flutter/services/product_store.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();


}

class _SearchScreenState extends State<SearchScreen> {
  var _store = StoreData();
  List<Product> products = [];

  String searchQuery="";

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainColor,
        toolbarHeight: screenHeight * 0.1,
        title: Container(
          height: screenHeight * 0.09,
          padding: EdgeInsets.all(10),
          child: TextField(
            onChanged: (value){
              setState(() {
                searchQuery=value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Search on Buy it',
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              prefixIcon: Icon(
                Icons.search,
                color: kMainColor,
              ),
              alignLabelWithHint: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(5),
              ),

            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _store.searchByProductOrCategory(searchQuery),
          builder: (context, snapshot) {
            if (snapshot.hasData && searchQuery !=null) {
              products.clear();
              for (var doc in snapshot.data.docs)
                products.add(Product.fromJson(doc.data(), doc.id));
              return products.length == 0
                  ? Center(
                child: Text("No Search Result"),
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
