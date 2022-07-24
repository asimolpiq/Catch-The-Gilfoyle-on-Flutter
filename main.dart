import 'package:catchthegilfoylegame/catch_the_gilfoyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catch The Gilfoyle',
      debugShowCheckedModeBanner: false,
      home: CatchTheGilfoyle(),
      theme: _customTheme(),
    );
  }

  ThemeData _customTheme() {
    return ThemeData.dark().copyWith(
      appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light),
    );
  }
}
