import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toastmsg extends StatelessWidget {
  final String message; // Text to be displayed in the toast
  final FToast toast;
  final Color backgroundColor;
  final Color frontColor;
  final Icon icon; // Instance of FToast (passed from the parent widget)

  const Toastmsg(
      {super.key,
      required this.message,
      required this.toast,
      required this.backgroundColor,
      required this.frontColor,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: backgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 12.0),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: frontColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
