import 'package:flutter/material.dart';
import 'package:image_app/Consts.dart';
import 'package:image_app/Components/inputfield.dart';
import 'package:image_app/Screens/mainScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_app/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatelessWidget {
  late String? email;
  late String? password;
  late String? Username;
  late String? password2;

  @override
  Widget build(BuildContext context) {

    Future addData(String email,String username)async{
      await FirebaseFirestore.instance.collection('users').add({
        'email':email,
        'username':username
      });
    }

    Future signUp() async {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ));
      try{
      FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email!, password: password!);
      addData(email!, Username!);
    } on FirebaseAuthException catch (e){
      print(e);
    }
      navigatorkey.currentState!.popUntil((route) => route.isFirst);
    }


    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges() ,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Somthing went wrong'),);
          } else if (snapshot.hasData) {
            return mainScreen();
          } else {
            return Scaffold(
              backgroundColor: Maincolor,
              body: SafeArea(
                child: ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 30, right: 30, top: 30, bottom: 30),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Maincolor,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 10,
                              spreadRadius: 0,
                              offset: Offset(2.0, 2.0),
                            )
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            const Text('Enter Your Email*', style: textStyle),
                            const SizedBox(
                              height: 15,
                            ),
                            InputField(
                                hint: 'Email',
                                fieldCallBack: (value) {
                                  email = value;
                                }),
                            const Text(
                              'Enter a Password*',
                              style: textStyle,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            InputField(
                                hint: 'Password',
                                fieldCallBack: (value) {
                                  password = value;
                                }),
                            InputField(
                                hint: 'Password',
                                fieldCallBack: (value) {
                                  password2 = value;
                                }),
                            const Text(
                              'Choose a User Name',
                              style: textStyle,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            InputField(
                                hint: 'User Name',
                                fieldCallBack: (value) {
                                  Username = value;
                                }),
                            const SizedBox(
                              height: 40,
                            ),
                            Center(
                                child: SizedBox(
                                  height: 70,
                                  width: 400,
                                  child: TextButton(
                                    onPressed: () {
                                      if (password2 != password) {
                                        print('Re Enter Password');
                                      }
                                      else if (Username == null){
                                        print('username = null');
                                      }
                                      else
                                        signUp();

                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10),
                                        ),
                                      ),
                                      overlayColor:
                                      const MaterialStatePropertyAll(
                                          Colors.black12),
                                      backgroundColor:
                                      const MaterialStatePropertyAll(
                                          Secondcolor),
                                    ),
                                    child: const Text(
                                      'Save',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
    );
  }
}
