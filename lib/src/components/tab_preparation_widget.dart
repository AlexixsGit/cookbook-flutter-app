import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/recipe.dart';

class TabPreprationWidget extends StatelessWidget {
  final Recipe recipe;
  const TabPreprationWidget({this.recipe, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
      children: [
        Text(
          recipe.name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          recipe.description,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Preparation',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        Column(
          children: List.generate(recipe.steps.length, (int index) {
            final step = recipe.steps[index];
            return ListTile(
              leading: Text(
                '${index + 1}',
                style: TextStyle(
                    fontSize: 25,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              title: Text(step),
            );
          }),
        )
      ],
    );
  }
}
