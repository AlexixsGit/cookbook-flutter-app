import 'package:cookbook_app/src/connection/server_controller.dart';
import 'package:cookbook_app/src/screens/home_page.dart';
import 'package:cookbook_app/src/screens/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/user.dart';

import 'screens/login_page.dart';

ServerController _serverController = ServerController();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.cyan,
          accentColor: Colors.cyan[300],
          accentIconTheme: IconThemeData(color: Colors.white)),
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          switch (settings.name) {
            case '/':
              return LoginPage(_serverController, context);
            case '/home':
              User loggedUser = settings.arguments;
              _serverController.loggedUser = loggedUser;
              return HomePage(_serverController);
            case '/register':
              User loggedUser = settings.arguments;
              return RegisterPage(
                _serverController,
                context,
                userToEdit: loggedUser,
              );
          }
        });
      },
    );
  }
}
