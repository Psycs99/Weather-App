// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class Temas {
  // ignore: non_constant_identifier_names
  ThemeData Tema() {
    const Color colorAppBar = Colors.blue;
    const Color colorTexto = Colors.white;
    const Color colorBoxShadow = Colors.red;
    const Color colorBackGround = Colors.red;
    const Color colorBotton = Colors.deepOrange;
    const Color colorPrimary = Colors.deepPurple;

    return ThemeData(
        appBarTheme: const AppBarTheme(color: colorAppBar),
        backgroundColor: colorBackGround,
        buttonColor: colorBotton,
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: colorTexto),
          bodyText2: TextStyle(color: colorTexto),
        ),
        primaryColor: colorPrimary,
        cardTheme: const CardTheme(elevation: 10, color: colorBoxShadow),
        cardColor: colorBoxShadow);
  }
}
