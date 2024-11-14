import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double defaultMargin = 24.0;

Color primaryColor = const Color(0xFF5B9EE1);
Color secondaryColor = const Color(0xFF38ABBE);
Color tertiaryColor = const Color(0xFF2B2844);
Color alertColor = const Color(0xFFED6363);
Color priceColor = const Color(0xFF54D643);
Color backgroundPrimaryColor = const Color(0xFF1A2530);
Color backgroundSecondaryColor = const Color(0xFF161F28);
Color backgroundTertiaryColor = const Color(0xFF242231);
Color backgroundFourthColor = const Color(0xFF252836);
Color primaryTextColor = const Color(0xFFE1E1E1);
Color secondaryTextColor = const Color(0xFF504F5E);
Color subtitleTextColor = Colors.grey;
Color onSecondaryColor = const Color(0xFFFFFFFF);

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

TextStyle alertTextStyle = GoogleFonts.poppins(
  color: alertColor,
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semibold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
