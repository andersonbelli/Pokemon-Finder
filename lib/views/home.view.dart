import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokemon_finder/controllers/pokemon.controller.dart';
import 'package:pokemon_finder/models/pokemon.model.dart';
import 'package:pokemon_finder/stores/home.store.dart';
import 'package:pokemon_finder/stores/search.store.dart';
import 'package:pokemon_finder/stores/user.store.dart';
import 'package:pokemon_finder/views/widgets/pokemon_types_list.dart';
import 'package:pokemon_finder/views/widgets/pokemon_list.view.widget.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var userStore = Provider.of<UserStore>(context);
    var homeStore = Provider.of<HomeStore>(context);
    var searchStore = Provider.of<SearchStore>(context);

    final _pokemonController = PokemonController();

    TextEditingController _searchBoxTextController =
        new TextEditingController();

    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Observer(
            builder: (_) => searchStore.searchBoxWidth == 0
                ? Text("Pokemon Finder")
                : Container(
                    width: searchStore.searchBoxWidth,
                    height: 45,
                    child: TextField(
                      maxLines: 1,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(20),
                      ],
                      expands: false,
                      maxLengthEnforced: false,
                      onSubmitted: (_) => makeASearch(searchStore, homeStore,
                          _searchBoxTextController, _pokemonController),
                      decoration: InputDecoration(
                        counterText: "",
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
                    makeASearch(searchStore, homeStore,
                        _searchBoxTextController, _pokemonController);
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
                padding: const EdgeInsets.only(right: 8.0, left: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Observer(
                        builder: (_) => SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            homeStore.listName,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ),
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
                            Observer(builder: (_) => Icon(homeStore.sortIcon)),
                          ],
                        ),
                        onPressed: () {
                          homeStore.changeSortIcon();
                        }),
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

  void makeASearch(
      SearchStore searchStore,
      HomeStore homeStore,
      TextEditingController _searchBoxTextController,
      PokemonController _pokemonController) {
    if (searchStore.searchIcon == Icons.cancel) {
      homeStore.updateCurrentList(homeStore.loadedList);
      searchStore.setSearchBoxIcon(Icons.search);
      searchStore.setSearchBoxWidth();
    } else if (searchStore.searchBoxWidth != 0 &&
        _searchBoxTextController.text.isNotEmpty) {
      List<Pokemon> filterResult = _pokemonController.filterListToSearchedValue(
        _searchBoxTextController.text,
        homeStore.loadedList,
      );

      if (filterResult.length == 0) {
        showSnackBar(
            scaffoldKey: _scaffoldKey, message: 'Sorry, nothing was found 😔');
        searchStore.setSearchBoxWidth();
      } else {
        homeStore.updateCurrentList(filterResult);
        homeStore.changeListName(_searchBoxTextController.text);
        searchStore.setSearchBoxIcon(Icons.cancel);
      }

      FocusScope.of(context).unfocus();
    } else {
      searchStore.setSearchBoxWidth();
    }
  }

  void showSnackBar({@required scaffoldKey, @required String message}) {
    final snackBar =
        SnackBar(backgroundColor: Colors.red.shade900, content: Text(message));
    scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
