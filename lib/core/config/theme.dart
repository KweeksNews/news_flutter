import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

mixin THEME {
  static final ThemeData light = ThemeData(
    primaryColor: const Color(0xFF000000),
    canvasColor: const Color(0xFFF6F8FD),
    shadowColor: const Color(0xB3F6F8FD),
    fontFamily: 'Quicksand',
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF000000),
      secondary: Color(0xFFDD9933),
      shadow: Color(0x05000000),
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xFFF6F8FD),
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
      color: Color(0xFFF6F8FD),
    ),
    tabBarTheme: const TabBarTheme(
      unselectedLabelColor: Color(0xFFAAAAAA),
      labelColor: Color(0xFFDD9933),
      indicator: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Color(0x40DD9933),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFFFFFFF),
      selectedItemColor: Color(0xFFDD9933),
      unselectedItemColor: Color(0xFF555555),
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFFFFFFFF),
    ),
    cardTheme: const CardTheme(
      color: Color(0xFFFFFFFF),
      shadowColor: Color(0x05000000),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        overlayColor: MaterialStateProperty.all(
          const Color(0x05000000),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          const Color(0xFFDD9933),
        ),
      ),
    ),
    primaryTextTheme: const TextTheme(
      headline1: TextStyle(
        color: Color(0xFF000000),
        fontSize: 20,
        fontWeight: FontWeight.w700,
        fontFamily: 'Quicksand',
      ),
      headline2: TextStyle(
        color: Color(0xFF000000),
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Quicksand',
      ),
      headline3: TextStyle(
        height: 1.2,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        fontFamily: 'Quicksand',
      ),
      headline4: TextStyle(
        color: Color(0xFF000000),
        fontSize: 17,
        fontWeight: FontWeight.w300,
        fontFamily: 'Quicksand',
      ),
      headline5: TextStyle(
        color: Color(0xFF000000),
        fontSize: 17,
        fontWeight: FontWeight.w400,
        fontFamily: 'Quicksand',
      ),
      headline6: TextStyle(
        color: Color(0xFF999999),
        fontSize: 13,
        fontWeight: FontWeight.w400,
        fontFamily: 'Quicksand',
      ),
      subtitle1: TextStyle(
        color: Color(0xFF000000),
        height: 1.2,
        fontSize: 15,
        fontWeight: FontWeight.w600,
        fontFamily: 'Montserrat',
      ),
      subtitle2: TextStyle(
        color: Color(0xFF000000),
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: 'Montserrat',
      ),
      bodyText1: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 12,
        fontWeight: FontWeight.w600,
        fontFamily: 'Montserrat',
      ),
      bodyText2: TextStyle(
        color: Color(0xFF999999),
        fontSize: 12,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Color(0xFF000000),
        height: 1.5,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        fontFamily: 'Montserrat',
      ),
      headline2: TextStyle(
        color: Color(0xFF000000),
        height: 1.3,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      headline3: TextStyle(
        color: Color(0xFF000000),
        height: 1.3,
        fontSize: 19,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      headline4: TextStyle(
        color: Color(0xFF000000),
        height: 1.3,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      headline5: TextStyle(
        color: Color(0xFF000000),
        height: 1.2,
        fontSize: 17,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      headline6: TextStyle(
        color: Color(0xFF000000),
        height: 1.2,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      bodyText1: TextStyle(
        color: Color(0xFF111111),
        height: 1.5,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        fontFamily: 'Montserrat',
      ),
      bodyText2: TextStyle(
        color: Color(0xFF111111),
        height: 1.2,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        fontFamily: 'Montserrat',
      ),
    ),
  );

  static final ThemeData dark = ThemeData(
    primaryColor: const Color(0xFFFFFFFF),
    canvasColor: const Color(0xFF000000),
    shadowColor: const Color(0xB3000000),
    fontFamily: 'Quicksand',
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFFFFFFF),
      secondary: Color(0xFFDD9933),
      shadow: Color(0x05000000),
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xFF000000),
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
      color: Color(0xFF000000),
    ),
    tabBarTheme: const TabBarTheme(
      unselectedLabelColor: Color(0xFFAAAAAA),
      labelColor: Color(0xFFDD9933),
      indicator: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Color(0x40DD9933),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF171717),
      selectedItemColor: Color(0xFFDD9933),
      unselectedItemColor: Color(0xFF555555),
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    iconTheme: const IconThemeData(
      color: Color(0xFF000000),
    ),
    cardTheme: const CardTheme(
      color: Color(0xFF171717),
      shadowColor: Color(0x0DFFFFFF),
    ),
    primaryTextTheme: const TextTheme(
      headline1: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 20,
        fontWeight: FontWeight.w700,
        fontFamily: 'Quicksand',
      ),
      headline2: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Quicksand',
      ),
      headline3: TextStyle(
        height: 1.2,
        fontSize: 13,
        fontWeight: FontWeight.w600,
        fontFamily: 'Quicksand',
      ),
      headline4: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 17,
        fontWeight: FontWeight.w300,
        fontFamily: 'Quicksand',
      ),
      headline5: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 17,
        fontWeight: FontWeight.w400,
        fontFamily: 'Quicksand',
      ),
      headline6: TextStyle(
        color: Color(0xFF999999),
        fontSize: 13,
        fontWeight: FontWeight.w400,
        fontFamily: 'Quicksand',
      ),
      subtitle1: TextStyle(
        color: Color(0xFFFFFFFF),
        height: 1.2,
        fontSize: 15,
        fontWeight: FontWeight.w600,
        fontFamily: 'Montserrat',
      ),
      subtitle2: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: 'Montserrat',
      ),
      bodyText1: TextStyle(
        color: Color(0xFF000000),
        fontSize: 12,
        fontWeight: FontWeight.w600,
        fontFamily: 'Montserrat',
      ),
      bodyText2: TextStyle(
        color: Color(0xFF999999),
        fontSize: 12,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
        color: Color(0xFFFFFFFF),
        height: 1.5,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        fontFamily: 'Montserrat',
      ),
      headline2: TextStyle(
        color: Color(0xFFFFFFFF),
        height: 1.3,
        fontSize: 20,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      headline3: TextStyle(
        color: Color(0xFFFFFFFF),
        height: 1.3,
        fontSize: 19,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      headline4: TextStyle(
        color: Color(0xFFFFFFFF),
        height: 1.3,
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      headline5: TextStyle(
        color: Color(0xFFFFFFFF),
        height: 1.2,
        fontSize: 17,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      headline6: TextStyle(
        color: Color(0xFFFFFFFF),
        height: 1.2,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: 'Montserrat',
      ),
      bodyText1: TextStyle(
        color: Color(0xFFEEEEEE),
        height: 1.5,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        fontFamily: 'Montserrat',
      ),
      bodyText2: TextStyle(
        color: Color(0xFFEEEEEE),
        height: 1.2,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        fontFamily: 'Montserrat',
      ),
    ),
  );
}
