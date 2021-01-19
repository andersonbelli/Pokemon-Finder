import 'package:flutter/material.dart';
import 'package:pokemon_finder/controllers/pokemon.controller.dart';
import 'package:pokemon_finder/models/pokemon.model.dart';
import 'package:pokemon_finder/models/pokemon_type.model.dart';
import 'package:pokemon_finder/stores/home.store.dart';
import 'package:provider/provider.dart';

class PokemonList extends StatelessWidget {
  const PokemonList({
    @required PokemonController controller,
    @required List<Pokemon> searchList,
    @required List<PokemonType> itemsList,
  })  : _controller = controller,
        _searchList = searchList,
        _itemsList = itemsList;

  final PokemonController _controller;
  final List<Pokemon> _searchList;
  final List<PokemonType> _itemsList;

  @override
  Widget build(BuildContext context) {
    var homeStore = Provider.of<HomeStore>(context);

    return _searchList.isEmpty
        ? FutureBuilder(
            future: _controller.loadHomeList(
              _itemsList,
              homeStore.sortIcon == Icons.arrow_upward ? true : false,
            ),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  break;
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                  break;
                case ConnectionState.active:
                  break;
                case ConnectionState.done:
                  homeStore.updateLoadedList(snapshot.data);

                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        Pokemon item = snapshot.data[i];

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
                      });
                  break;
              }
              return Text("Nothing to see here 🤔");
            },
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: _searchList.length,
            itemBuilder: (context, i) {
              Pokemon item = _searchList[i];

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
            });
  }
}
