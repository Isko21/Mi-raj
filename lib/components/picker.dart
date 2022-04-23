import 'package:flutter/material.dart';

class PickerItem {
  String label;

  PickerItem(this.label);
}

class PickerWidget extends StatefulWidget {
  final List<PickerItem> pickerItems;

  const PickerWidget({
    Key? key,
    required this.pickerItems,
  }) : super(key: key);

  @override
  _PickerWidgetState createState() => _PickerWidgetState();
}

class _PickerWidgetState extends State<PickerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
