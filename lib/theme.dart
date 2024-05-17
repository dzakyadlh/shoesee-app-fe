import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double defaultMargin = 32.0;

Color primaryColor = const Color(0xFF6C5ECF);
Color secondaryColor = const Color(0xFF38ABBE);
Color alertColor = const Color(0xFFED6363);
Color priceColor = const Color(0xFF2C96F1);
Color backgroundPrimaryColor = const Color(0xFF1F1D2B);
Color backgroundSecondaryColor = const Color(0xFF2B2937);
Color backgroundTertiaryColor = const Color(0xFF242231);
Color primaryTextColor = const Color(0xFFE1E1E1);
Color secondaryTextColor = const Color(0xFF999999);
Color subtitleTextColor = const Color(0xFF504F5E);

TextStyle primaryTextStyle = GoogleFonts.poppins(
  color: primaryTextColor,
);

TextStyle secondaryTextStyle = GoogleFonts.poppins(
  color: secondaryTextColor,
);

TextStyle subtitleTextStyle = GoogleFonts.poppins(
  color: subtitleTextColor,
);

TextStyle priceTextStyle = GoogleFonts.poppins(
  color: priceColor,
);

TextStyle buttonTextStyle = GoogleFonts.poppins(
  color: primaryColor,
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semibold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
