import 'package:flutter/cupertino.dart';

class AdminMode extends ChangeNotifier {
  bool isAdmin = false;

  changeAdminState() {
    isAdmin = !isAdmin;
    notifyListeners();
  }
}
