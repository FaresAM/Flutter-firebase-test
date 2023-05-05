import 'package:flutter/foundation.dart';
import 'package:image_app/Components/image_button.dart';
import 'dart:io';
import 'package:flutter/material.dart';


class PicList extends ChangeNotifier{

  List<Image_button> Pics = [];
  String username = '';

  void addItem(File Image){
    Pics.insert(0,Image_button(TheImage: Image));
    notifyListeners();
  }
  int get PicsLength{
    return Pics.length;
  }









}