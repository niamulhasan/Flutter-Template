import 'package:flutter/material.dart';

class ThemeColors {
  static Color getDeepColor(String color) {
    if (color == 'blue') {
      return Colors.blue[400];
    }
    if (color == 'red') {
      return Colors.red[400];
    }
    if (color == 'green') {
      // return HexColor("#1CD69B");
      return Colors.greenAccent[700];
    }
    if (color == 'purple') {
      return Colors.purple[400];
    }
  }

  static Color getLightColor(String color) {
    if (color == 'blue') {
      return Colors.blue[100];
    }
    if (color == 'red') {
      return Colors.red[100];
    }
    if (color == 'green') {
      // return HexColor("#A8EECA");
      return Colors.green[50];
    }
    if (color == 'purple') {
      return Colors.purple[50];
    }
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
