import 'package:cookbook_app/src/connection/server_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/recipe.dart';

class HomePage extends StatefulWidget {
  final ServerController serverController;

  HomePage(this.serverController, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cookbook'),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: widget.serverController.getRecipes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final list = snapshot.data;
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                Recipe recipe = list[index];
                return Card(
                  child: Image.file(recipe.photo),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
