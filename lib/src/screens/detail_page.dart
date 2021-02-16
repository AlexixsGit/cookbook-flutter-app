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
              )
            ];
          },
          body: TabBarView(
            children: [Text('Hello'), Text('Details screen')],
          ),
        ),
      ),
    );
  }
}
