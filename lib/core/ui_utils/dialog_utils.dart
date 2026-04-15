import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DialogUtils {
  static void showLoading(BuildContext context, {bool dismissible = true}) {
    showDialog(
      barrierDismissible: dismissible,
      context: context,
      builder: (context) => PopScope(
        canPop: dismissible,
        child: CupertinoAlertDialog(content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(child: CircularProgressIndicator()),
        
          ],
        ),),
      )
    );
  }

  static void hideDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static void showToastMessage({required String message,required   Color backgroundColor  }) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
