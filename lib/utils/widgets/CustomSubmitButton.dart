import 'package:flutter/material.dart';

class CustomSubmitButton extends StatelessWidget {
  const CustomSubmitButton({Key? key, required this.onPressed})
    : super(key: key);
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      onPressed: onPressed,
      child: Container(
        padding: EdgeInsets.all(12),
        child: Text(
          'Submit',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
