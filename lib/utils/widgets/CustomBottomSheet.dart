import 'package:flutter/material.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({
    super.key,
    required this.title,
    required this.alertMesssage,
    required this.leftButtonText,
    required this.rightButtonText,
    required this.leftButtonOnPressed,
    required this.rightButtonOnPressed,
  });
  final String title;
  final String alertMesssage;
  final String leftButtonText;
  final String rightButtonText;
  final VoidCallback leftButtonOnPressed;
  final VoidCallback rightButtonOnPressed;

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {
        Navigator.pop(context);
      },
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.2,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              spacing: 10,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(widget.alertMesssage, style: TextStyle(fontSize: 13)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: widget.leftButtonOnPressed,
                      child: Text(widget.leftButtonText),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: widget.rightButtonOnPressed,
                      child: Text(widget.rightButtonText),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
