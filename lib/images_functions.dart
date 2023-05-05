import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_app/Components/storage_functions.dart';


class ImageFunctions{
  storage_functions Storage = storage_functions();


  Future<File?> getImage({required ImageSource source,File? imageFile,}) async {

    final file = await ImagePicker().pickImage(source: source);
    if (file?.path != null || file?.path != file?.path) {

      imageFile = File(file!.path);
      final file_path = file.path;
      final file_name = file.name;

      Storage.uploadFile(file_path!, file_name!);



    }
    return imageFile;
  }


}