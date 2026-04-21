import 'package:evently_app/core/resources/colors_manager.dart';
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

  static void showConfirmationDialog(
  BuildContext context, {
  required String message,
  String? title,
  String positiveButtonText = "Yes",
  String negativeButtonText = "No",
  VoidCallback? onPositivePressed,
  VoidCallback? onNegativePressed,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: title != null ? Text(title) : null,
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            if (onNegativePressed != null) onNegativePressed();
          },
          child: Text(negativeButtonText, style: TextStyle(color: ColorsManager.darkBlue),),
        ),
        TextButton(
  
          onPressed: () {
            Navigator.pop(context);
            if (onPositivePressed != null) onPositivePressed();
          },
          child: Text(positiveButtonText , 
         style: TextStyle(color: ColorsManager.darkBlue),),
        ),
      ],
    ),
  );
}
}
