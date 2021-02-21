import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokemon_finder/controllers/pokemon.controller.dart';
import 'package:pokemon_finder/models/pokemon.model.dart';
import 'package:pokemon_finder/stores/home.store.dart';
import 'package:pokemon_finder/stores/search.store.dart';
import 'package:pokemon_finder/views/widgets/pokemon_list.view.widget.dart';
import 'package:pokemon_finder/views/widgets/pokemon_types_list.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _pokemonController = PokemonController();

  TextEditingController _searchBoxTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    var homeStore = Provider.of<HomeStore>(context);
    var searchStore = Provider.of<SearchStore>(context);

    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Observer(
            builder: (_) => searchStore.searchBoxWidth == 0
                ? Text(
                    "Pokemon Finder",
                    style: TextStyle(color: Colors.white),
                  )
                : Container(
                    width: searchStore.searchBoxWidth,
                    height: 45,
                    child: TextField(
                      key: Key("searchTextFieldKey"),
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
                  color: Colors.white,
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
              child: PokemonTypesListWidget(pokemonData: homeStore.typesList),
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
                            key: Key("listNameTextKey"),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    FlatButton(
                        key: Key("nameOrderButtonKey"),
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
                          homeStore.updateCurrentList(
                            _pokemonController.sortListByName(
                              homeStore.currentList,
                              homeStore.sortIcon == Icons.arrow_upward
                                  ? true
                                  : false,
                            ),
                          );
                        }),
                  ],
                ),
              ),
            ),
            Divider(),
            Expanded(
                flex: 8,
                child: Observer(builder: (_) {
                  if (homeStore.homeListStatus is InitialHomeListStatus ||
                      homeStore.homeListStatus is LoadingHomeListStatus) {
                    return Center(
                        child: CircularProgressIndicator(
                            backgroundColor: Colors.pinkAccent.shade700));
                  } else if (homeStore.homeListStatus is LoadedHomeListStatus) {
                    return PokemonListWidget();
                  } else if (homeStore.homeListStatus is ErrorHomeListStatus) {
                    ErrorHomeListStatus error = homeStore.homeListStatus;
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 12),
                        child: Column(
                          children: [
                            Text(
                              "Something went wrong recovering the list\n😔",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18, height: 2),
                            ),
                            SizedBox(height: 12),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: BorderSide(color: Colors.transparent)),
                              child: Text(
                                "Try again",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                              color: Colors.pinkAccent.shade700,
                              onPressed: () {},
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  return Text("Unknown error :(");
                }))
          ],
        ));
  }

  @override
  void didChangeDependencies() {
    var _homeStore = Provider.of<HomeStore>(context);

    if (_homeStore.loadedList.length == 0) {
      new Future.delayed(Duration.zero, () async {
        final loadedList = await _pokemonController
            .loadHomeList(
          _homeStore.typesList,
          _homeStore.sortIcon == Icons.arrow_upward ? true : false,
        )
            .catchError((e) {
          return _homeStore.homeListStatus =
              ErrorHomeListStatus(e.message.toString());
        });

        _homeStore.homeListStatus = LoadedHomeListStatus();
        _homeStore.updateLoadedList(loadedList);
        _homeStore.updateCurrentList(loadedList);
      });
    }

    super.didChangeDependencies();
  }

  @visibleForTesting
  void makeASearch(
      SearchStore searchStore,
      HomeStore homeStore,
      TextEditingController _searchBoxTextController,
      PokemonController _pokemonController) {
    if (searchStore.searchIcon == Icons.cancel) {
      homeStore.updateCurrentList(homeStore.loadedList);
      searchStore.setSearchBoxIcon(Icons.search);
      homeStore.changeListName("Pokemon");
      _searchBoxTextController.text = "";
    } else if (searchStore.searchBoxWidth != 0 &&
        _searchBoxTextController.text.isNotEmpty) {
      List<Pokemon> filterResult = _pokemonController.filterListToSearchedValue(
        _searchBoxTextController.text,
        homeStore.loadedList,
      );

      if (filterResult.length == 0) {
        showSnackBar(
            scaffoldKey: _scaffoldKey, message: 'Sorry, nothing was found 😔');
        searchStore.toggleSearchBox(false);
      } else {
        homeStore.updateCurrentList(filterResult);
        homeStore.changeListName("Search: ${_searchBoxTextController.text}");
        searchStore.setSearchBoxIcon(Icons.cancel);
        searchStore.toggleSearchBox(false);
      }

      FocusScope.of(context).unfocus();
    } else if (searchStore.searchBoxWidth != 0 &&
        _searchBoxTextController.text.isEmpty) {
      searchStore.toggleSearchBox(false);
    } else {
      searchStore.toggleSearchBox(true);
    }
  }

  void showSnackBar({@required scaffoldKey, @required String message}) {
    final snackBar =
        SnackBar(backgroundColor: Colors.red.shade900, content: Text(message));
    scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
