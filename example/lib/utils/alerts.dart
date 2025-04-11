import 'package:flutter/material.dart';

import '../../main.dart';

class Alerts {
  static double bottomPadding = 50;

  static showSuccessSnackBar(String message) {
    if(message.isEmpty) return;
    ScaffoldMessenger.of(navigatorKey.currentContext!).removeCurrentSnackBar();
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black87,
        behavior: SnackBarBehavior.floating,
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 20,
              width: 2,
              color: Colors.green,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        margin: EdgeInsets.only(bottom: bottomPadding,left: 16,right: 16),
      ),
    );
  }

  static showErrorSnackBar(String message,{BuildContext? context}) {
    if(message.isEmpty) return;
    ScaffoldMessenger.of(context??navigatorKey.currentContext!).removeCurrentSnackBar();
    WidgetsBinding.instance.addPostFrameCallback((_){
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black87,
          behavior: SnackBarBehavior.floating,
          content: Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 20,
                  width: 2,
                  color: Colors.red,
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          margin: EdgeInsets.only(bottom: bottomPadding,left: 16,right: 16),
        ),
      );
    });
  }

  static showInfoSnackBar(String message) {
    if(message.isEmpty) return;
    ScaffoldMessenger.of(navigatorKey.currentContext!).removeCurrentSnackBar();
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black87,
        behavior: SnackBarBehavior.floating,
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 20,
              width: 2,
              color: Colors.blue,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        margin: EdgeInsets.only(bottom: bottomPadding,left: 16,right: 16),
      ),
    );
  }
}
