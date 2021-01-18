import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemon_finder/controllers/pokemon.controller.dart';
import 'package:pokemon_finder/models/pokemon.model.dart';
import 'package:pokemon_finder/models/pokemon_type.model.dart';
import 'package:pokemon_finder/stores/home.store.dart';
import 'package:pokemon_finder/stores/search.store.dart';
import 'package:pokemon_finder/views/widgets/PokemonTypesList.dart';
import 'package:provider/provider.dart';
import 'package:pokemon_finder/stores/user.store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

List<Pokemon> loadedList = [];

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double _searchBoxWidth = 0;
  List<Pokemon> searchList = [];

  @override
  Widget build(BuildContext context) {
    var userStore = Provider.of<UserStore>(context);
    var homeStore = Provider.of<HomeStore>(context);
    var searchStore = Provider.of<SearchStore>(context);

    final _controller = PokemonController();
    TextEditingController _searchBoxTextController =
        new TextEditingController();

    final userData = "Anderson";
    final List<PokemonType> pokemonData = [
      PokemonType(
          name: "normal",
          thumbnailImage:
              "https://vortigo.blob.core.windows.net/files/pokemon/assets/fighting.png"),
      PokemonType(
          name: "fighting",
          thumbnailImage:
              "https://vortigo.blob.core.windows.net/files/pokemon/assets/normal.png"),
      PokemonType(
          name: "normal",
          thumbnailImage:
              "https://vortigo.blob.core.windows.net/files/pokemon/assets/fighting.png"),
      PokemonType(
          name: "fighting",
          thumbnailImage:
              "https://vortigo.blob.core.windows.net/files/pokemon/assets/normal.png"),
      PokemonType(
          name: "flying",
          thumbnailImage:
              "https://vortigo.blob.core.windows.net/files/pokemon/assets/flying.png")
    ];

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Observer(
            builder: (_) => searchStore.searchBoxWidth == 0
                ? Text("Pokemon Finder")
                : Container(
                    width: searchStore.searchBoxWidth,
                    height: 45,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Search",
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                      controller: _searchBoxTextController,
                    ),
                  ),
          ),
          actions: [
            Observer(
              builder: (_) => IconButton(
                  icon: searchStore.searchIcon,
                  onPressed: () {
                    if (searchStore.searchBoxWidth != 0 &&
                        _searchBoxTextController.text.isNotEmpty) {
                      List<Pokemon> filterResult =
                          filterList(_searchBoxTextController.text, loadedList);

                      homeStore.updateCurrentList(filterResult);
                      searchStore.setSearchBoxIcon(Icon(Icons.cancel));
                    }
                    searchStore.setSearchBoxWidth();
                  }),
            )
          ],
        ),
        body: Flex(
          mainAxisSize: MainAxisSize.max,
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: PokemonTypesList(pokemonData: pokemonData),
            ),
            Expanded(
              flex: 8,
              child: Observer(builder: (_) {
                return PokemonList(
                    controller: _controller, itemsList: homeStore.currentList);
              }),
            )
          ],
        ));
  }

  List<Pokemon> filterList(String query, List<Pokemon> listToSearch) {
    List<Pokemon> resultFilter = listToSearch
        .where((element) =>
            element.name
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            element.abilities
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            element.type.toString().toLowerCase().contains(query.toLowerCase()))
        .toList();

    return resultFilter;
  }
}

class PokemonList extends StatelessWidget {
  const PokemonList(
      {@required PokemonController controller,
      @required List<Pokemon> itemsList})
      : _controller = controller,
        _itemsList = itemsList;

  final PokemonController _controller;
  final List<Pokemon> _itemsList;

  @override
  Widget build(BuildContext context) {
    return _itemsList.isEmpty
        ? FutureBuilder(
            future: _controller.getPokemonList(),
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
                  loadedList = snapshot.data;

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
            itemCount: _itemsList.length,
            itemBuilder: (context, i) {
              Pokemon item = _itemsList[i];

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
