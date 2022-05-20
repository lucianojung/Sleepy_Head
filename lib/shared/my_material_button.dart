import 'package:flutter/material.dart';

class MyMaterialButton extends StatefulWidget {
  String text;
  MaterialStateProperty<Color> backgroundColor;
  VoidCallback onPressed;

  MyMaterialButton({required this.text, required this.backgroundColor, required this.onPressed, Key? key}) : super(key: key);

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
        child: Text(widget.text),
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
