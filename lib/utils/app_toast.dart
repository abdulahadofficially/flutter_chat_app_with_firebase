import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppToast {
  static void showSuccessToast(String message) {
    _showToast(message, Colors.green);
  }

  static void showErrorToast(String message) {
    _showToast(message, Colors.red);
  }

  static void showInfoToast(String message) {
    _showToast(message, Colors.blue);
  }

  static void _showToast(String message, Color bgColor) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: bgColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
