import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokemon_finder/controllers/pokemon.controller.dart';
import 'package:pokemon_finder/models/pokemon.model.dart';
import 'package:pokemon_finder/stores/home.store.dart';
import 'package:pokemon_finder/stores/search.store.dart';
import 'package:pokemon_finder/stores/user.store.dart';
import 'package:pokemon_finder/views/widgets/pokemon_types_list.dart';
import 'package:pokemon_finder/views/widgets/pokemon_list.view.widget.dart';
import 'package:provider/provider.dart';

List<Pokemon> loadedList = [];

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  double _searchBoxWidth = 0;
  List<Pokemon> searchList = [];

  IconData _sortIcon = Icons.arrow_upward;

  @override
  Widget build(BuildContext context) {
    var userStore = Provider.of<UserStore>(context);
    var homeStore = Provider.of<HomeStore>(context);
    var searchStore = Provider.of<SearchStore>(context);

    final _pokemonController = PokemonController();

    TextEditingController _searchBoxTextController =
        new TextEditingController();

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
                  icon: Icon(searchStore.searchIcon),
                  onPressed: () {
                    if (searchStore.searchIcon == Icons.cancel) {
                      homeStore.updateCurrentList(loadedList);
                      searchStore.setSearchBoxIcon(Icons.search);
                      searchStore.setSearchBoxWidth();
                    } else if (searchStore.searchBoxWidth != 0 &&
                        _searchBoxTextController.text.isNotEmpty) {
                      List<Pokemon> filterResult =
                          _pokemonController.filterListToSearchedValue(
                        _searchBoxTextController.text,
                        loadedList,
                      );

                      homeStore.updateCurrentList(filterResult);
                      searchStore.setSearchBoxIcon(Icons.cancel);
                    } else {
                      searchStore.setSearchBoxWidth();
                    }
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
              child: PokemonTypesList(pokemonData: homeStore.typesList),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pokemon",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    FlatButton(
                        child: Row(
                          children: [
                            Text(
                              "Name",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(_sortIcon)
                          ],
                        ),
                        onPressed: () {}),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Observer(builder: (_) {
                return PokemonList(
                    controller: _pokemonController,
                    searchList: homeStore.currentList,
                    itemsList: homeStore.typesList);
              }),
            )
          ],
        ));
  }
}
