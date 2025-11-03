import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppColors {
  AppColors._();

  static const white = Color(0xFFFAFAFA);
  static const black = Color(0xFF131313);

  static const red = Color(0xFFCA0825);
  static const lightRed = Color(0xFFF44336);

  static const blueGrey = Color(0xFF607D8B);

  static const green = Color(0xFF21C13B);
  static const darkGreen = Color(0xFF4CAF50);

  static const yellow = Color(0xFFE7E20E);

  static const blue = Color(0xFF4373D9);
  static const darkBlue = Color(0xFF133E99);

  static const deepOrange = Color(0xFFFF5722);

  static const grey = Color(0xFF9E9E9E);
  static const darkGrey = Color(0xFF424242);

  // ➕ Added for standings clarity
  static const purple = Color(0xFF7E57C2); // 3rd place highlight
  static const lightGrey = Color(0xFFE0E0E0); // mid-table background

  static const blueGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[darkBlue, blue],
  );

  static const redGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[lightRed, red],
  );
}
