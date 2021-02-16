import 'package:cookbook_app/src/components/my_drawer_widget.dart';
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
        title: Text(
          'My Cookbook',
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: MyDrawer(
        serverController: widget.serverController,
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
                return Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                  child: GestureDetector(
                    onTap: () => _showDetails(context, recipe),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Card(
                          child: Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(recipe.photo),
                              fit: BoxFit.cover),
                        ),
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          color: Colors.black.withOpacity(0.35),
                          child: ListTile(
                            title: Text(
                              recipe.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16),
                            ),
                            subtitle: Text(
                              recipe.user.nickname,
                              style: TextStyle(color: Colors.white),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.favorite,
                              ),
                              onPressed: () {
                                _addOrRemoveFavorite(recipe);
                              },
                              iconSize: 32,
                            ),
                          ),
                        ),
                      )),
                    ),
                  ),
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }

  void _addOrRemoveFavorite(Recipe recipe) {
    widget.serverController.addOrRemoveFavorite(recipe);
  }

  _showDetails(BuildContext context, Recipe recipe) {
    Navigator.pushNamed(context, '/details', arguments: recipe);
  }
}
