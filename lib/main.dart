import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:image_app/Screens/Slides.dart';
import 'package:image_app/pic_list.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
final navigatorkey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>PicList(),
      child: MaterialApp(
        navigatorKey: navigatorkey,
        debugShowCheckedModeBanner: false,
        home: Slides(),
      ),
    );
  }
}
