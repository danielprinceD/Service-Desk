import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({super.key, required this.child});
  final Widget child;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 11, bottom: 11),
      alignment: Alignment.centerLeft,
      width: double.infinity,
      child: widget.child,
    );
  }
}
