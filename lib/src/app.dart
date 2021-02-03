import 'package:flutter/material.dart';

import 'screens/login_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => LoginPage(),
      },
    );
  }
}
