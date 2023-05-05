import 'package:flutter/material.dart';
import 'dart:io';

class Image_button extends StatelessWidget {

 File TheImage;

  Image_button({required this.TheImage});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: (){},
      child: Image(
        image: FileImage(TheImage),
        fit: BoxFit.cover,
      ),
    );
  }
}
