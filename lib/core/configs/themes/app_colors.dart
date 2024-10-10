import 'package:flutter/material.dart';

class AppColors {
  static const Color gradientPlaylistStart = Color(0xFF3B4FB6);
  static const Color gradientPlaylistMiddle =  Color(0xFF202A5E);
  static const Color gradientPlaylistEnd = Color(0xFF0A0C16);
  static List<Color> gradientPlaylist = [
    gradientPlaylistStart,
    const Color(0xFF2E3C8A),
    gradientPlaylistMiddle,
    const Color(0xFF131832),
    gradientPlaylistEnd,
  ];

  static const  Color bodyTextColor = Color(0xFF898989);

  static const Color textFieldBackground = Color(0x0A0E0E0E); // 4% opacity
}
