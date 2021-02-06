import 'package:flutter/cupertino.dart';

class ModalHub extends ChangeNotifier {
  bool _isLoading = false;

  // ignore: unnecessary_getters_setters
  bool get isLoading => _isLoading;

  // ignore: unnecessary_getters_setters

  changeLoadingState() {
    _isLoading = ! _isLoading;
    notifyListeners();
  }
}
