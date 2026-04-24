import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager{
  static ThemeData light = ThemeData(
    colorScheme: ColorScheme.light(
  primary: ColorsManager.darkBlue,
  secondary: ColorsManager.blue,
  background: ColorsManager.whiteF4,
   surface: ColorsManager.whiteF4,
),
cardTheme: CardThemeData(
  color: ColorsManager.whiteF4, // 👈 لون الكونتينر الافتراضي
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.r),
  ),
),
cardColor: ColorsManager.whiteF4,
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.whiteF4,
      foregroundColor: ColorsManager.black,
      centerTitle: true,
      titleTextStyle: GoogleFonts.poppins(color: ColorsManager.black,fontSize: 18.sp, fontWeight: FontWeight.w500)
    ),
    dividerColor: ColorsManager.grey,
    primaryColor: ColorsManager.white,
    scaffoldBackgroundColor: ColorsManager.whiteF4,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorsManager.darkBlue,
      foregroundColor: ColorsManager.white,
shape: CircleBorder()
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(

      backgroundColor: ColorsManager.white,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorsManager.darkBlue,
      unselectedItemColor: ColorsManager.darkGrey,
        showUnselectedLabels: true,
      showSelectedLabels: true
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.white, width: 1.w),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.grey, width: 1.w),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: Colors.red, width: 1.w),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: Colors.red, width: 1.w),
      ),
      fillColor: ColorsManager.white,
      hintStyle: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.normal, color: ColorsManager.darkGrey),
      filled: true,
      prefixIconColor: ColorsManager.grey,
      suffixIconColor: ColorsManager.grey,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: REdgeInsets.symmetric(vertical: 9),
        backgroundColor: ColorsManager.darkBlue,
        foregroundColor: ColorsManager.white,
        textStyle: GoogleFonts.poppins(fontSize: 20.sp, fontWeight: FontWeight.w500, color: Colors.white)
      ),
    ),

    textTheme: TextTheme(
      bodyMedium:GoogleFonts.poppins(fontSize: 16.sp, fontWeight: FontWeight.w400, color: ColorsManager.darkGrey, ), 
              bodySmall: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w400, color: ColorsManager.black),

      labelSmall: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w600, color: ColorsManager.darkBlue, ),
      labelMedium: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w400, color: ColorsManager.darkGrey),
      labelLarge: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w600, color: ColorsManager.white),
      headlineLarge: GoogleFonts.poppins(fontSize: 24.sp, fontWeight:FontWeight.w600,color: ColorsManager.darkBlue ),
      headlineSmall: GoogleFonts.poppins(fontSize: 14.sp, fontWeight:FontWeight.w400,color: ColorsManager.darkGrey ),
      headlineMedium: GoogleFonts.poppins(fontSize: 20.sp, fontWeight:FontWeight.w500,color: ColorsManager.black ),
      titleSmall: GoogleFonts.poppins(fontSize: 16.sp, fontWeight:FontWeight.w600,color: ColorsManager.darkBlue )
     , titleMedium: GoogleFonts.poppins(fontSize: 14.sp, fontWeight:FontWeight.w500,color: ColorsManager.darkBlue ),
     titleLarge: GoogleFonts.poppins(fontSize: 18.sp, fontWeight:FontWeight.w500,color: ColorsManager.darkBlue ),

        displayMedium: GoogleFonts.poppins(fontSize: 20.sp, fontWeight: FontWeight.w600, color: ColorsManager.black)
        ,displaySmall: GoogleFonts.poppins(fontSize: 14.sp, fontWeight: FontWeight.w400, color: ColorsManager.darkGrey)
        ,displayLarge: GoogleFonts.poppins(fontSize: 16.sp, fontWeight: FontWeight.w500, color: ColorsManager.black)

    )
  );
     static ThemeData dark = ThemeData(
    useMaterial3: true,

    colorScheme: ColorScheme.dark(
      primary: ColorsManager.blue,
      secondary: ColorsManager.darkBlue,
      background: ColorsManager.dark,
      surface: ColorsManager.dark,
    ),
    cardTheme: CardThemeData(
  color: ColorsManager.dark, 
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.r),
    side: BorderSide(color: ColorsManager.blue, width: 0.5),
  ),
),

    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.dark,
      foregroundColor: ColorsManager.white,
      centerTitle: true,
      titleTextStyle: GoogleFonts.poppins(
        color: ColorsManager.white,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      ),
    ),

    scaffoldBackgroundColor: ColorsManager.dark,
    primaryColor: ColorsManager.dark,

    dividerColor: ColorsManager.blue,

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ColorsManager.blue,
      foregroundColor: ColorsManager.white,
      shape: const CircleBorder(),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorsManager.dark,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorsManager.blue,
      unselectedItemColor: ColorsManager.white,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ),

    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.blue, width: 1.w),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.blue, width: 1.w),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: Colors.red, width: 1.w),
      ),
      filled: true,
      fillColor: ColorsManager.dark,
      hintStyle: GoogleFonts.poppins(
        fontSize: 14.sp,
        color: ColorsManager.white,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: REdgeInsets.symmetric(vertical: 9),
        backgroundColor: ColorsManager.blue,
        foregroundColor: ColorsManager.white,
        textStyle: GoogleFonts.poppins(
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    textTheme: TextTheme(
      bodyMedium: GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: ColorsManager.white,
      ),
      bodySmall: GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: ColorsManager.white,
      ),

      labelSmall: GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: ColorsManager.blue,
      ),
      labelMedium: GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: ColorsManager.white,
      ),
      labelLarge: GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: ColorsManager.white,
      ),

      headlineLarge: GoogleFonts.poppins(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: ColorsManager.white,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.blue,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: ColorsManager.white,
      ),

      titleLarge: GoogleFonts.poppins(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.white,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.blue,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: ColorsManager.blue,
      ),

      displayLarge: GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: ColorsManager.white,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: ColorsManager.white,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: ColorsManager.white,
      ),
    ),
    cardColor: ColorsManager.dark,
  );
}