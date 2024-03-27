import 'package:flutter/material.dart';

class ThemeBuilder {
  static ThemeData themeData(BuildContext context) => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade300),
        useMaterial3: true,
        elevatedButtonTheme: elevatedButtonThemeData(context),
        textButtonTheme: textButtonThemeData(context),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyMedium: const TextStyle(fontSize: 13),
            ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade500,
          titleTextStyle: const TextStyle(fontSize: 22),
        ),
      );

  static TextButtonThemeData textButtonThemeData(BuildContext context) =>
      TextButtonThemeData(
        style: ButtonStyle(
          padding: const MaterialStatePropertyAll(EdgeInsets.zero),
          fixedSize: MaterialStateProperty.all(const Size.fromHeight(30)),
        ),
      );

  static ElevatedButtonThemeData elevatedButtonThemeData(BuildContext context) =>
      ElevatedButtonThemeData(
        style: ButtonStyle(
          side: MaterialStateProperty.resolveWith<BorderSide>(
              (states) => const BorderSide(color: Colors.black)),
          backgroundColor: background(context),
          shape: MaterialStateProperty.resolveWith<OutlinedBorder>((_) {
            return RoundedRectangleBorder(borderRadius: BorderRadius.circular(20));
          }),
          elevation: MaterialStateProperty.resolveWith<double>(
              (states) => states.contains(MaterialState.pressed) ? 0.0 : 5.0),
          textStyle: MaterialStateProperty.resolveWith<TextStyle>((states) {
            return const TextStyle(color: Colors.black);
          }),
        ),
      );

  static MaterialStateProperty<Color> simpleBackground() =>
      MaterialStateProperty.resolveWith<Color>((states) => Colors.white);

  static MaterialStateProperty<Color?>? background(BuildContext context) {
    return MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) {
        return Theme.of(context).colorScheme.primary.withOpacity(0.5);
      }
      return null; // Use the component's default.
    });
  }
}
