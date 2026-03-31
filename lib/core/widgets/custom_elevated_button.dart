import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
   CustomElevatedButton({super.key,required this.title,this.onClick, this.style});
String title;
     final ButtonStyle? style;
VoidCallback? onClick;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onClick,style:style  ,child:Text(title));
  }
}
