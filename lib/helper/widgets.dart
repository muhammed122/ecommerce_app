import 'package:badges/badges.dart';
import 'package:ecommerce_flutter/helper/popup_menu.dart';
import 'package:ecommerce_flutter/model/product_model.dart';
import 'package:ecommerce_flutter/provider/cart_provider.dart';
import 'package:ecommerce_flutter/ui/user/cart_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';

Widget customTextField(String hint, IconData icon,
    TextEditingController controller, TextInputType type) {
  return Container(
    padding: EdgeInsets.only(top: 20, left: 16, right: 16),
    child: TextFormField(
      keyboardType: type,
      controller: controller,
      validator: (value) {
        if (value.isEmpty) return 'Please enter this field';
        return null;
      },
      obscureText: hint == 'Enter your Password' ? true : false,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.white54,
        ),
        filled: true,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white54),
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: kMainColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 0,
              color: kEditTextFocusColor,
            )),
        focusColor: kEditTextFocusColor,
      ),
    ),
  );
}

Widget tabItem(
  String title,
) {
  return Padding(
    padding: const EdgeInsets.all(6.0),
    child: Text(
      '$title',
      style: TextStyle(fontSize: 16, color: Colors.white54),
    ),
  );
}

Widget productTextField(
    String hint, TextEditingController controller, TextInputType type) {
  return Container(
    padding: EdgeInsets.only(top: 20, left: 16, right: 16),
    child: TextFormField(
      controller: controller,
      validator: (value) {
        if (value.isEmpty) return 'Please enter this field';
        return null;
      },
      keyboardType: type,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white54),
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: kMainColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              width: 0,
              color: kEditTextFocusColor,
            )),
        focusColor: kEditTextFocusColor,
      ),
    ),
  );
}

Widget logoWidget(BuildContext context) {
  var relativeHeight = MediaQuery.of(context).size.height * 0.05;
  return Container(
    margin: EdgeInsets.only(top: relativeHeight),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('images/icons/white_cart.png'),
        Text(
          "Buy It",
          style: TextStyle(
              fontFamily: 'pacifico', fontSize: 25, color: Colors.white),
        ),
      ],
    ),
  );
}

Widget cartIcon(BuildContext context, int count) {
  return GestureDetector(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: count != 0
          ? Badge(
              badgeContent: Text(
                "$count",
                style: TextStyle(color: Colors.white),
              ),
              child: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            )
          : Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
    ),
    onTap: () {
      Navigator.pushNamed(context, CartScreen.route);
    },
  );
}

Widget userInfoItem(String title, String value) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.fiber_manual_record,
              size: 12,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 20, color: kMainColor),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),
              ),
              title != "Email Address"
                  ? GestureDetector(
                      child: Text(
                        'Edit',
                        style: TextStyle(color: Colors.lightBlue),
                      ),
                      onTap: () {
                        print(title);
                      },
                    )
                  : Text(
                      'Not Editable',
                      style: TextStyle(color: Colors.black38),
                    ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Widget productItem(Product product, BuildContext context) {
//   return GestureDetector(
//     onTapUp: (details) {
//       double dx = details.globalPosition.dx;
//       double dy = details.globalPosition.dy;
//       double dx1 = MediaQuery.of(context).size.width - dx;
//       double dy1 = MediaQuery.of(context).size.height - dy;
//
//       showMenu(
//           context: context,
//           position: RelativeRect.fromLTRB(dx, dy, dx1, dy1),
//           items: [
//             MyPopupMenuItem(
//               child: Text('Edit'),
//               onClick: () {
//                 print("Edit");
//               },
//             ),
//             MyPopupMenuItem(
//               child: Text('Delete'),
//               onClick: () {
//                 print("delete");
//                 //alertDialog(context, "Delete Product", "");
//               },
//             ),
//           ]);
//     },
//     child: Container(
//       child: Card(
//         elevation: 5,
//         clipBehavior: Clip.antiAlias,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                   //     child: Image.asset(
//                   //   "images/icons/boot.png",
//                   //   width: MediaQuery.of(context).size.width,
//                   // )),
//                   child: Image.network(
//                 product.productImage,
//                 width: MediaQuery.of(context).size.width,
//               )),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 4),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         product.productName,
//                         style: TextStyle(
//                           fontSize: 20,
//                         ),
//                       ),
//                     ),
//                     Text(
//                       '${product.productPrice} LE',
//                       style: TextStyle(fontSize: 14, color: kButtonColor),
//                     ),
//                   ],
//                 ),
//               ),
//               Text(
//                 product.productDesc,
//                 style: TextStyle(fontSize: 16, color: Colors.black54),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
// }

Widget bottomNavigationBar(BuildContext context) {
  return Theme(
    data: Theme.of(context).copyWith(
        // sets the background color of the `BottomNavigationBar`
        canvasColor: kMainColor,
        // sets the active color of the `BottomNavigationBar` if `Brightness` is light
        primaryColor: Colors.white,
        textTheme: Theme.of(context)
            .textTheme
            .copyWith(caption: TextStyle(color: Colors.white54))),
    // sets the inactive color of the `BottomNavigationBar`
    child: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 0,
      items: [
        BottomNavigationBarItem(title: Text('Home'), icon: Icon(Icons.home)),
        BottomNavigationBarItem(
            title: Text('Search'), icon: Icon(Icons.search)),
        BottomNavigationBarItem(
            title: Text('Profile'), icon: Icon(Icons.person)),
        BottomNavigationBarItem(
            title: Text('Logout'), icon: Icon(Icons.exit_to_app)),
      ],
    ),
  );
}

Widget mainAppbar(BuildContext context, String title) {
  return AppBar(
      backgroundColor: kMainColor,
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontFamily: fontName),
      ),
      actions: [
        cartIcon(context, Provider.of<CartProvider>(context).cartCount),
      ]);
}

myAlertDialog(
    BuildContext mContext, String title, String content, Function function) {
  // show the dialog
  showDialog(
    context: mContext,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          FlatButton(
              onPressed: () async {
                await function();
                Navigator.pop(mContext);

              },
              child: Text('Yes')),
          FlatButton(
              onPressed: () async {
                Navigator.pop(mContext);
              },
              child: Text('Cancel')),
        ],
      );
    },
  );
}

mySnackBar(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(message),
  ));
}

void showToast(BuildContext context, String message) {
  print("contexttttttttttttttt $context");
  final scaffold = Scaffold.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text("$message"),
    ),
  );
}
