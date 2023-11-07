import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerProvider extends ChangeNotifier {
  // single image
  XFile? _file;

  XFile? get file => _file;

  void pickImage() async {
    XFile? image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
    );
    if (image != null) {
      _file = image;

      notifyListeners();
    }
  }

  void pickVideo() async {
    XFile? vid = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
      maxDuration: const Duration(seconds: 45),
    );
    if (vid != null) {
      _file = vid;

      notifyListeners();
    }
  }

  // multi image
  List<XFile> _files = [];

  List<XFile> get images => _files;

  void pickImages() async {
    List<XFile>? images = await ImagePicker().pickMultiImage(
      imageQuality: 40,
    );

    if (images != null || images!.isNotEmpty) {
      _files = List.from(_files)..addAll(images);

      notifyListeners();
    }
  }

  void reset() {
    _files = [];
    _file = null;

    notifyListeners();
  }

  void delete(XFile file) {
    _files.remove(file);

    notifyListeners();
  }
}
