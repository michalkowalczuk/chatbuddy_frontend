import 'package:flutter/material.dart';

class ButtonStyles {
  static ButtonStyle elevatedFilled = ElevatedButton.styleFrom(
    textStyle: const TextStyle(
      fontSize: 17
    ),
    backgroundColor: OtherStyles.mainBlue,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32.0),
    ),
    padding: const EdgeInsets.symmetric(
      vertical: 8.0,
      horizontal: 32.0,
    ),
  );

  static ButtonStyle elevatedOutline = ElevatedButton.styleFrom(
    textStyle: const TextStyle(
        fontSize: 17
    ),
    foregroundColor: OtherStyles.mainBlue,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32.0),
      side: BorderSide(color: OtherStyles.mainBlue),
    ),
    padding: const EdgeInsets.symmetric(
      vertical: 8.0,
      horizontal: 32.0,
    ),
  );
}

class OtherStyles {
  static Color mainBlue = const Color.fromRGBO(35, 64, 88, 1);
  static Color bubbleBg = const Color.fromRGBO(230, 231, 233, 1);
}
