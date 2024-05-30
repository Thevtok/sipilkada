// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/statistik/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: mainColor,
    cardColor: background,
    splashColor: Colors.grey,
    scaffoldBackgroundColor: Colors.white,
    indicatorColor: AppColors.contentColorRed,
    textTheme: GoogleFonts.nunitoTextTheme(
      ThemeData.light().textTheme,
    ).copyWith(
      bodyLarge: GoogleFonts.nunito(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: nearlyBlack,
      ),

      bodyMedium: GoogleFonts.nunito(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.contentColorRed,
      ),
      bodySmall: GoogleFonts.nunito(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: nearlyBlack,
      ),
      displayLarge: GoogleFonts.nunito(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: AppColors.contentColorRed,
      ),
      displayMedium: GoogleFonts.nunito(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: AppColors.contentColorRed,
          fontStyle: FontStyle.italic),
      displaySmall: GoogleFonts.nunito(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: nearlyBlack,
      ),

      labelLarge: GoogleFonts.nunito(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: AppColors.contentColorBlack,
      ),
      labelMedium: GoogleFonts.nunito(
        fontSize: 13,
        fontWeight: FontWeight.normal,
        color: Colors.grey.shade700,
      ),
      labelSmall: GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      titleLarge: GoogleFonts.nunito(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: AppColors.contentColorRed,
      ),

      titleMedium: GoogleFonts.nunito(
        fontSize: 13,
        fontWeight: FontWeight.normal,
        color: AppColors.contentColorBlack,
      ),
      titleSmall: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColors.contentColorRed,
      ),

      // Tambahkan gaya teks lainnya sesuai kebutuhan
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: GoogleFonts.nunito(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: mainColor,
    cardColor: const Color.fromARGB(255, 29, 38, 43),
    splashColor: Colors.white,
    indicatorColor: Colors.white,
    scaffoldBackgroundColor: Colors.black,
    textTheme: GoogleFonts.nunitoTextTheme(
      ThemeData.dark().textTheme,
    ).copyWith(
      bodyLarge: GoogleFonts.nunito(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.contentColorWhite,
      ),
      bodyMedium: GoogleFonts.nunito(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      bodySmall: GoogleFonts.nunito(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: nearlyBlack,
      ),
      displayLarge: GoogleFonts.nunito(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      displayMedium: GoogleFonts.nunito(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: Colors.white,
          fontStyle: FontStyle.italic),
      displaySmall: GoogleFonts.nunito(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: AppColors.contentColorWhite,
      ),

      labelLarge: GoogleFonts.nunito(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: AppColors.contentColorWhite,
      ),
      labelMedium: GoogleFonts.nunito(
        fontSize: 13,
        fontWeight: FontWeight.normal,
        color: AppColors.contentColorWhite,
      ),
      labelSmall: GoogleFonts.nunito(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: const Color.fromARGB(255, 29, 38, 43),
      ),
      titleLarge: GoogleFonts.nunito(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: AppColors.contentColorWhite,
      ),

      titleMedium: GoogleFonts.nunito(
        fontSize: 13,
        fontWeight: FontWeight.normal,
        color: AppColors.contentColorWhite,
      ),
      titleSmall: GoogleFonts.nunito(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColors.contentColorWhite,
      ),

      // Tambahkan gaya teks lainnya sesuai kebutuhan
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: const Color.fromARGB(255, 29, 38, 43),
      titleTextStyle: GoogleFonts.nunito(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );

  static const Color mainColor = Color(0xfff77b00);
  static const Color secondColor = Color(0xfffec926);
  static const Color notWhite = Color(0xFFEDF0F2);

  static const Color nearlyWhite = Color(0xFFFAFAFA);
  static const Color background = Color(0xFFF2F3F8);
  static const Color nearlyDarkBlue = Color(0xFF2633C5);

  static const Color nearlyBlue = Color(0xFF00B6F0);
  static const Color nearlyBlack = Color(0xFF213333);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color spacer = Color(0xFFF2F2F2);
  static const String fontName = 'Roboto';

  static const Color blue = Color(0xFF03a9f4);
  static const Color indigo = Color(0x0ff25476);
  static const Color purple = Color(0xFFab47bc);
  static const Color pink = Color(0xFFf06292);
  static const Color red = Color(0xFFdf5645);
  static const Color orange = Color(0xFFfa9f1b);
  static const Color yellow = Color(0xFFffe405);
  static const Color green = Color(0x0fffcc2e);
  static const Color teal = Color(0xFF26a69a);
  static const Color cyan = Color(0xFF0dcaf0);
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray = Color(0xFFcbd0d8);
  static const Color darkGray = Color(0xFF9ea2a8);
  static const Color gray100 = Color(0xFFf9fafc);
  static const Color gray200 = Color(0xFFedf1f6);
  static const Color gray300 = Color(0xFFe7ecf3);
  static const Color gray400 = Color(0xFFe7ecf3);
  static const Color gray500 = Color(0xFFe1e7f0);
  static const Color gray600 = Color(0xFFcbd0d8);
  static const Color gray700 = Color(0xFFb4b9c0);
  static const Color grey = Color(0xFF9ea2a8);
  static const Color gray800 = Color(0xFF9ea2a8);
  static const Color gray900 = Color(0xFF878b90);
  static const Color primary = Color(0xFF25476a);
  static const Color secondary = Color(0xFF26a69a);
  static const Color success = Color(0xFF9FCC2E);
  static const Color info = Color(0xFF03a9f4);
  static const Color warning = Color(0xFFfa9f1b);
  static const Color danger = Color(0xFFdf5645);
  static const Color light = Color(0xFFe1e7f0);
  static const Color dark = Color(0xFF373c43);
  // siwaslu color
  static const Color utama = Color.fromRGBO(220, 187, 109, 1);

  static const borderRadius = 22.5;
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) hexColor = 'FF$hexColor';
    return int.parse(hexColor, radix: 16);
  }
}
