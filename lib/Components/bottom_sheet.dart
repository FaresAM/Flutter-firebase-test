
import 'package:flutter/material.dart';
import 'package:image_app/Consts.dart';
import 'package:image_app/pic_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:image_app/images_functions.dart';
import 'storage_functions.dart';

class Bottomsheetstuff extends StatefulWidget {
  const Bottomsheetstuff({
    Key? key,
  }) : super(key: key);

  @override
  State<Bottomsheetstuff> createState() => _BottomsheetstuffState();
}

class _BottomsheetstuffState extends State<Bottomsheetstuff> {
  File? ImageFile;
  storage_functions Storage = storage_functions();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        color: Secondcolor,
      ),
      height: 50,
      width: 1000,
      child: TextButton(
        style: const ButtonStyle(
          overlayColor: MaterialStatePropertyAll(Colors.black12),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
          ),
        ),
        onPressed: () {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20.0),
              ),
            ),
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 100,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  color: Secondcolor,
                ),
                child: Expanded(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        style: const ButtonStyle(
                            overlayColor:
                                MaterialStatePropertyAll(Colors.black12)),
                        onPressed: () async {
                          ImageFile = await ImageFunctions()
                              .getImage(source: ImageSource.camera);
                          Provider.of<PicList>(context, listen: false)
                              .addItem(ImageFile!);
                          //firebase storage
                          ImageFile = null;
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                            Text(
                              'Take picture',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    const VerticalDivider(
                      thickness: 2,
                      width: 1,
                    ),
                    Expanded(
                      child: TextButton(
                        style: const ButtonStyle(
                            overlayColor:
                                MaterialStatePropertyAll(Colors.black12)),
                        onPressed: () async {
                          // getImage(source: ImageSource.gallery);
                          ImageFile = await ImageFunctions()
                              .getImage(source: ImageSource.gallery,);
                          Provider.of<PicList>(context, listen: false)
                              .addItem(ImageFile!);
                          ImageFile = null;

                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.photo_album,
                              color: Colors.white,
                            ),
                            Text(
                              'Choose from gallery',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )),
              );
            },
          );
        },
        child: const Icon(
          Icons.add_a_photo,
          color: Colors.white,
        ),
      ),
    );
  }
}
