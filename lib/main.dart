import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:sobaca_mobile/authentication/login.dart';
import "package:provider/provider.dart";
import 'package:sobaca_mobile/screens/forumPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) {
          CookieRequest request = CookieRequest();
          return request;
        },
        child: MaterialApp(
          title: 'Sobaca Mobile',
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.green
          ),
          home: const LoginPage(),
        ));
  }
}