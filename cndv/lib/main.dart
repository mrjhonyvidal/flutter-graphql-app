import 'package:cndv/src/pages/tabs_page.dart';
import 'package:cndv/src/theme/theme.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CNDV App',
      theme: cndvTheme,
      debugShowCheckedModeBanner: false,
      home: TabsPage()
    );
  }
}