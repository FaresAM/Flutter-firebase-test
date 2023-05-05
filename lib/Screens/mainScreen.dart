
import 'package:image_app/pic_list.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:image_app/Consts.dart';
import 'package:image_app/Components/image_button.dart';
import 'package:image_app/Components/bottom_sheet.dart';
import 'package:image_app/Components/avatar_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_app/Components/storage_functions.dart';

class mainScreen extends StatelessWidget {

  String Username='';

  Future<String?> usernameGetter() async {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser?.email)
        .get();
     Username = snap.docs.first.get('username');

  }

  storage_functions Storage = storage_functions();

  @override
  Widget build(BuildContext context) {
    usernameGetter();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 50,
        backgroundColor: thirdcolor,
        toolbarHeight: 150,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: avatar_functions(),
            ),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: FutureBuilder(
                    future: usernameGetter(),
                    builder: (context, snapshot) {
                      return Text(Username,
                        style: TextStyle(color: Colors.grey, fontSize: 20),
                      );
                    })),
            const Flexible(
              child: SizedBox(
                width: 500,
              ),
            ),
            IconButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut();

              },
              icon: const Icon(
                Icons.power_settings_new,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
      backgroundColor: Maincolor,
      body: SafeArea(
           child: FutureBuilder(
             future: Storage.downloadURL(),
             builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
               if (snapshot.connectionState == ConnectionState.done &&
                   snapshot.hasData) {
                 return GridView.builder(
                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: 3,
                       mainAxisSpacing: 2,
                       crossAxisSpacing: 2,
                     ),
                     itemCount:snapshot.data!.length,
                     // Provider
                     //     .of<PicList>(context)
                     //     .PicsLength,
                     itemBuilder: (context, index) {
                       return Container(
                         child: Image.network(
                           snapshot.data![index],
                           fit: BoxFit.cover
                         ),
                       );
                     });
               }
               if (snapshot.connectionState == ConnectionState.waiting) {
                 return CircularProgressIndicator();
               }
               return Container();

             },
           )),

      bottomNavigationBar: const Bottomsheetstuff(),
    );
  }
}
