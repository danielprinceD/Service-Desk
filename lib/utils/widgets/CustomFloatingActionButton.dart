

import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatefulWidget {
  const CustomFloatingActionButton({super.key , this.onPressed , this.child });
  final VoidCallback? onPressed;
  final Widget? child;
  @override
  State<CustomFloatingActionButton> createState() => _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState extends State<CustomFloatingActionButton> {



  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: widget.onPressed,
        child: const Icon(Icons.add),
      );
  }
}