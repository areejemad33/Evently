
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextButton extends StatelessWidget {
   CustomTextButton({super.key, required this.title, this.align = TextAlign.center,  this.onTap});
String title;
TextAlign align;
VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return  InkWell(
        onTap:onTap,
        child: Text(title,

          textAlign: align,style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600,color:ColorsManager.blue,decoration: TextDecoration.underline, decorationColor: ColorsManager.blue)

         ));
  }
}
