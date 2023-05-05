import 'package:flutter/material.dart';
import 'package:image_app/Consts.dart';

class InputField extends StatefulWidget {
  late TextEditingController textController = TextEditingController();
  String hint;
  void Function(String?) fieldCallBack;

  InputField(
      {required this.hint,
      required this.fieldCallBack,
     });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
   bool Hide = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: thirdcolor, borderRadius: BorderRadius.circular(10)),
      child: TextField(
        controller: widget.textController,
        onChanged: widget.fieldCallBack,
        autofocus: false,
        cursorColor: Colors.grey,
        style: const TextStyle(color: Colors.grey, fontSize: 20),
        obscureText: widget.hint == 'Password' ? Hide : Hide=false,
        decoration: InputDecoration(
          hintText: widget.hint,
          suffix: widget.hint == 'Password'
              ? IconButton(
                  icon: const Icon(
                    Icons.remove_red_eye,
                  ),
                  color: Colors.grey,
                  alignment: Alignment.centerRight,
                  onPressed: () {
                    setState(() {
                      Hide=!Hide;
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(
                    Icons.clear,
                  ),
                  color: Colors.grey,
                  alignment: Alignment.centerRight,
                  onPressed: () {
                    widget.textController.clear();
                  }),
          border: InputBorder.none,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 20),
        ),
      ),
    );
  }
}
