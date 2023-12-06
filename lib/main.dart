import 'package:flutter/material.dart';
import 'package:sobaca_mobile/screens/forumPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Discussion Forum',
      home: ForumPage(),
    );
  }
}
