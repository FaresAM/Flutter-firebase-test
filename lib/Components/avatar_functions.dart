import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_app/images_functions.dart';

class avatar_functions extends StatefulWidget {
  @override
  State<avatar_functions> createState() => _avatar_functionsState();
}

class _avatar_functionsState extends State<avatar_functions> {

  File? avatarFile;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        avatarFile = await ImageFunctions()
            .getImage(source: ImageSource.gallery, imageFile: avatarFile);
        setState(() {
        });
      },
      child: CircleAvatar(
        radius: 60,
        foregroundImage: avatarFile == null? null : FileImage(avatarFile!),
      ),
    );
  }
}
