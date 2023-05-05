import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

class storage_functions{

  final storage = FirebaseStorage.instance;


  Future<void> uploadFile(String filePath, String fileName) async{
    File file = File(filePath);

    try{
      await storage.ref().child('posts${FirebaseAuth.instance.currentUser!.uid}').child(fileName).putFile(file);
    }on FirebaseException catch (e){
      print(e);
    }
  }

  Future<List<String>> downloadURL()async{

    ListResult Items = await FirebaseStorage.instance.ref().child('posts${FirebaseAuth.instance.currentUser!.uid}').listAll();
    List<String> URLs = [];
    Items.items[1].getDownloadURL();
    for(int i = 0 ; i<Items.items.length;i++){
      print(Items.items[i].name);
      URLs[i] = await storage.ref().child('posts${FirebaseAuth.instance.currentUser!.uid}/${Items.items[i].name}').getDownloadURL().toString();
      print('*************************************** no print');
    //   await storage.ref().child('posts${FirebaseAuth.instance.currentUser!.uid}/${Items.items[i].name}').getDownloadURL();
     }

    return URLs;



  }

}