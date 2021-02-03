import 'package:flutter/material.dart';

import 'screens/login_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.cyan,
          accentColor: Colors.white),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => LoginPage(),
      },
    );
  }
}
