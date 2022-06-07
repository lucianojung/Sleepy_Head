import 'package:flutter/material.dart';

import '../theme_config.dart';

class MyMaterialButton extends StatefulWidget {
  String text;
  MaterialStateProperty<Color> backgroundColor;
  VoidCallback onPressed;
  TextStyle textStyle;

  MyMaterialButton({required this.text, required this.backgroundColor, required this.onPressed, required this.textStyle, Key? key}) : super(key: key);

  @override
  _MyMaterialButtonState createState() => _MyMaterialButtonState();

}

class _MyMaterialButtonState extends State<MyMaterialButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      child: OutlinedButton(
        onPressed: widget.onPressed,
        child: SingleChildScrollView(child: Text(widget.text, style: widget.textStyle)),
        style: ButtonStyle(
          backgroundColor: widget.backgroundColor,
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          ),
        ),
      ),
    );
  }
}
