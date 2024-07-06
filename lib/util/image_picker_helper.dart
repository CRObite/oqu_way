import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper{

  Future<Uint8List?> pickImageBytesFromGallery() async {

    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      Uint8List? bytes = await pickedFile.readAsBytes();
      return bytes;
    }else{
      return null;
    }

  }

  Future<Uint8List?> pickImageBytesFromCamera() async {

    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      Uint8List? bytes = await pickedFile.readAsBytes();
      return bytes;
    }else{
      return null;
    }

  }


}