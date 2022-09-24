import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color orangeClr = Color(0xCFFF8746);
const Color pinkClr = Color(0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF252424);
const Color darkHeaderClr = Color(0xFF424242);

TextStyle get headingStyle1{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      color: Get.isDarkMode ? Colors.white : Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  );
} TextStyle get subHeadingStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      color: Get.isDarkMode ? Colors.white : Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
} TextStyle get titleStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      color: Get.isDarkMode ? Colors.white : Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  );
} TextStyle get subTitle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      color: Get.isDarkMode ? Colors.white : primaryClr,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  );
} TextStyle get bodyStyle{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      color: Get.isDarkMode ? Colors.white : Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  );
}
TextStyle get bodyStyle2{
  return GoogleFonts.lato(
    textStyle: TextStyle(
      color: Get.isDarkMode ? Colors.grey[200] : primaryClr,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  );
}

class Themes {
  static final lightTheme = ThemeData(
      backgroundColor: primaryClr,
      colorScheme: const ColorScheme.light(brightness: Brightness.light,
          secondary: Colors.deepPurpleAccent,primary: primaryClr),
      canvasColor: Colors.white,
      brightness: Brightness.light,
  );
  static final darkTheme = ThemeData(
    backgroundColor: Colors.black,
    colorScheme: const ColorScheme.light(brightness: Brightness.dark,
        secondary: Colors.deepPurpleAccent,primary: primaryClr),
    canvasColor: darkGreyClr,
    brightness: Brightness.dark,
  );
}
