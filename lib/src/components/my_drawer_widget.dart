import 'package:cookbook_app/src/connection/server_controller.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final ServerController serverController;

  const MyDrawer({this.serverController, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                      'https://backgrounddownload.com/wp-content/uploads/2018/09/navigation-drawer-background-image-1.jpg',
                    ),
                    fit: BoxFit.cover)),
            accountName: Text(
              serverController.loggedUser.nickname,
              style: TextStyle(color: Colors.white),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: FileImage(serverController.loggedUser.photo),
            ),
            onDetailsPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/register',
                  arguments: serverController.loggedUser);
            },
          ),
          ListTile(
            title: Text(
              'My Recipes',
              style: TextStyle(fontSize: 18),
            ),
            leading: Icon(
              Icons.book,
              color: Colors.green,
            ),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              'Favorites',
              style: TextStyle(fontSize: 18),
            ),
            leading: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/favorities');
            },
          ),
          ListTile(
            title: Text(
              'Logout',
              style: TextStyle(fontSize: 18),
            ),
            leading: Icon(
              Icons.power_settings_new,
              color: Colors.cyan,
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/');
            },
          )
        ],
      ),
    );
  }
}
