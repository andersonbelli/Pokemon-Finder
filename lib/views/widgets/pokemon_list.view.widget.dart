import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokemon_finder/controllers/pokemon.controller.dart';
import 'package:pokemon_finder/models/pokemon.model.dart';
import 'package:pokemon_finder/models/pokemon_type.model.dart';
import 'package:pokemon_finder/stores/home.store.dart';
import 'package:provider/provider.dart';

class PokemonListWidget extends StatefulWidget {
  @override
  _PokemonListWidgetState createState() => _PokemonListWidgetState();
}

class _PokemonListWidgetState extends State<PokemonListWidget> {
  @override
  Widget build(BuildContext context) {
    var homeStore = Provider.of<HomeStore>(context);

    return homeStore.currentList.length == 0
        ? Center(child: CircularProgressIndicator())
        : Observer(
            builder: (_) => ListView.builder(
                shrinkWrap: true,
                itemCount: homeStore.currentList.length,
                itemBuilder: (context, i) {
                  Pokemon item = homeStore.currentList[i];

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      maxRadius: 23,
                      backgroundImage: NetworkImage(item.thumbnailImage),
                    ),
                    title: Text(
                      item.name,
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                }),
          );
  }
}
