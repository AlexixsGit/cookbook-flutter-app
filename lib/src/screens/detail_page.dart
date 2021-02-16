import 'package:cookbook_app/src/components/tab_ingredients_widget.dart';
import 'package:cookbook_app/src/components/tab_preparation_widget.dart';
import 'package:cookbook_app/src/connection/server_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/recipe.dart';

class DetailPage extends StatefulWidget {
  final Recipe recipe;
  final ServerController serverController;

  DetailPage({this.recipe, this.serverController, key}) : super(key: key);

  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool favorite;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: Text(
                  widget.recipe.name,
                  style: TextStyle(color: Colors.white),
                ),
                expandedHeight: 320,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(widget.recipe.photo))),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                pinned: true,
                bottom: TabBar(
                  labelColor: Colors.white,
                  tabs: [
                    Tab(
                      child: Text(
                        'Ingredients',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Preparation',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                ),
                actions: [
                  IconButton(
                      icon: Icon(Icons.edit),
                      color: Colors.white,
                      onPressed: () {}),
                  IconButton(
                      icon: Icon(Icons.favorite),
                      color: Colors.white,
                      onPressed: () {}),
                  IconButton(
                      icon: Icon(Icons.help_outline),
                      color: Colors.white,
                      onPressed: () {})
                ],
              )
            ];
          },
          body: TabBarView(
            children: [
              TabIngredientsWidget(recipe: widget.recipe),
              TabPreprationWidget(
                recipe: widget.recipe,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getFavoriteWidget() {
    if (favorite != null) {
      if (favorite) {
        return IconButton(
            icon: Icon(Icons.favorite),
            color: Colors.red,
            onPressed: () async {
              widget.serverController.deleteFavorite(widget.recipe);
              setState(() {
                favorite = false;
              });
            });
      } else {
        return IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () async {
              widget.serverController.addFavorite(widget.recipe);
              setState(() {
                favorite = true;
              });
            });
      }
    } else {
      return Container(
        margin: EdgeInsets.all(15),
        width: 30,
        child: CircularProgressIndicator(),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    loadState();
  }

  void loadState() async {
    final state = await widget.serverController.isFavorite(widget.recipe);
    setState(() {
      this.favorite = state;
    });
  }
}
