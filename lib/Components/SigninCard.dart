import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_app/Consts.dart';
import 'package:image_app/Screens/SignUpScreen.dart';
import 'package:image_app/Components/inputfield.dart';
import 'package:image_app/main.dart';


class SigninCard extends StatelessWidget {
  late String password;
  late String email;

  @override
  Widget build(BuildContext context) {
    Future signIn() async {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ));
      try {
        FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      } on FirebaseAuthException catch (e) {
        print(e);
      }
      navigatorkey.currentState!.popUntil((route) => route.isFirst);
    }

    return Container(
      margin: const EdgeInsets.only(right: 40, left: 40, top: 110, bottom: 130),
      decoration: BoxDecoration(
          color: Maincolor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
                color: Colors.black,
                blurRadius: 10,
                spreadRadius: 0,
                offset: Offset(2.0, 2.0))
          ]),
      child: Padding(
        padding: const EdgeInsets.only(right: 15, left: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Flexible(
              child: Image(
                image: AssetImage('images/camera.png'),
                width: 150,
              ),
            ),
            InputField(
              hint: 'Email or User Name',
              //Just in case
              // textController: emailcontroller,
              fieldCallBack: (value) {
                email = value!;
              },
            ),
            InputField(
              hint: 'Password',
              fieldCallBack: (value) {
                password = value!;
              },
              //Just in case
              // textController: passwordcontroller,
            ),
            Container(
              width: 450,
              decoration: BoxDecoration(
                  color: Secondcolor, borderRadius: BorderRadius.circular(10)),
              child: MaterialButton(
                onPressed: () async {
                  signIn();
                },
                child: const Text(
                  'Log in',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t Have an account?',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SignUpScreen();
                    }));
                  },
                  child: const Text(
                    ' Sign Up',
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
