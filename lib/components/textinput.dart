import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    Key? key,
    required this.controller,
    required this.colorStr,
    required this.color,
    required this.label,
    required this.type,
    required this.icon,
  }) : super(key: key);

  final TextEditingController controller;
  final Color colorStr;
  final Color color;
  final String label;
  final TextInputType type;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(color: colorStr, fontSize: 17),
      cursorColor: color,
      keyboardType: type,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color, width: 2.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: color, width: 2.0),
        ),
        labelText: label,
        labelStyle: TextStyle(
          color: color,
        ),
        icon: Icon(
          icon.icon,
          color: color,
        ),
        border: OutlineInputBorder(),
      ),
    );
  }
}
