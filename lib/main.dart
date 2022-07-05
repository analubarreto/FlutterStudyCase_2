import 'package:flutter/material.dart';
import 'package:flutter_2/views/page_one.dart';
import 'package:flutter_2/views/page_two.dart';

void main() {
  runApp(const FlutterTwo());
}

class FlutterTwo extends StatelessWidget {
  const FlutterTwo({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'FlutterTwo',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: {
          '/': (_) => const PageOne(),
          '/pageTwo': (_) => const PageTwo(),
        });
  }
}
