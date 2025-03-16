import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_const.dart';

ThemeData appTheme(BuildContext context) {
  return ThemeData(
    textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
    appBarTheme: const AppBarTheme(
        color: AppConst.kBackgroundColor,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),centerTitle: false, elevation: 2, shadowColor: Colors.white),
    scaffoldBackgroundColor: AppConst.kBackgroundColor,
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
