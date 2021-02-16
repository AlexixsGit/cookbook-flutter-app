import 'package:flutter/material.dart';
import 'package:flutter_modulo1_fake_backend/modulo1_fake_backend.dart'
    as server;
import 'package:flutter_modulo1_fake_backend/models.dart';

class ServerController {
  User loggedUser;

  void init(BuildContext context) {
    server.generateData(context);
  }

  Future<User> login(String userName, String password) async {
    return await server.backendLogin(userName, password);
  }

  Future<bool> addUser(User user) async {
    return await server.addUser(user);
  }

  Future<List<Recipe>> getRecipes() async {
    return await server.getRecipes();
  }

  Future<bool> updateUser(User user) async {
    loggedUser = user;
    return await server.updateUser(user);
  }

  Future<List<Recipe>> getFavorities() async {
    return await server.getFavorites();
  }

  Future<Recipe> addOrRemoveFavorite(Recipe nFavorite) async {
    bool isFavorite = await server.isFavorite(nFavorite);

    if (isFavorite) {
      await server.deleteFavorite(nFavorite);
    } else {
      await server.addFavorite(nFavorite);
    }
    return nFavorite;
  }
}
