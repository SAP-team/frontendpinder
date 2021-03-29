import 'package:flutter/material.dart';
import 'package:pinder/authpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pinder',
      initialRoute: '/',
      routes: {
        '/': (context) => AuthMainPage(),
      },
    );
  }
}
