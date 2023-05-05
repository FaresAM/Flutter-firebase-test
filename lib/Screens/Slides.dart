import 'package:flutter/material.dart';
import 'package:image_app/Consts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:image_app/Components/SigninCard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'mainScreen.dart';

class Slides extends StatelessWidget {
  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }else if (snapshot.hasError){
            return const Center(child: Text('Somthing went wrong'),);
          } else if (snapshot.hasData) {
            return mainScreen();
          } else {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: Stack(
                children: [
                  PageView(
                    controller: _controller,
                    children: [
                      Container(
                        color: Maincolor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
                            const VerticalDivider(
                              color: Secondcolor,
                              thickness: 1.5,
                              indent: 250,
                              endIndent: 250,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Hello',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 270,
                                  child: const Text(
                                    'This is a testApp for firebase storage and some other stuff. ',
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.white),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        color: Maincolor,
                        child: SigninCard(),
                      )
                    ],
                  ),
                  Container(
                    alignment: const Alignment(0, 0.8),
                    child: SmoothPageIndicator(
                      controller: _controller,
                      count: 2,
                      effect: const ExpandingDotsEffect(
                          activeDotColor: Secondcolor, dotColor: Colors.white),
                    ),
                  )
                ],
              ),
            );
          }
        });
  }
}
