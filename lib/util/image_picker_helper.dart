import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper{

  Future<String?> pickImageBytesFromGallery() async {

    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      String? filePath = pickedFile.path;
      return filePath;
    } else {
      return null;
    }

  }

  Future<String?> pickImageBytesFromCamera() async {

    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      String? filePath = pickedFile.path;
      return filePath;
    } else {
      return null;
    }

  }


}