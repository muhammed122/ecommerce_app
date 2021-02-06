import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class MyImageProvider extends ChangeNotifier {
  File imageFile;
  ImagePicker _picker;

  MyImageProvider() {
    _picker = ImagePicker();
  }

  Future getImage() async {
    final image = await _picker.getImage(source: ImageSource.camera);
    imageFile = File(image.path);
    notifyListeners();
  }
}
