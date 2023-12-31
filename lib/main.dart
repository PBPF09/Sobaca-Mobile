import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:sobaca_mobile/authentication/login.dart';
import "package:provider/provider.dart";
import 'package:sobaca_mobile/user_registered/screens/profilePage.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MyApp(),
    ),
  );
}

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
          theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
          home: const LoginPage(),
        ));
  }
}
