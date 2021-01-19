import 'package:flutter/material.dart';
import 'package:pokemon_finder/controllers/pokemon_types.controller.dart';
import 'package:pokemon_finder/controllers/user.controller.dart';
import 'package:pokemon_finder/models/pokemon_type.model.dart';
import 'package:pokemon_finder/repositories/user.repository.dart';
import 'package:pokemon_finder/stores/home.store.dart';
import 'package:pokemon_finder/stores/user.store.dart';
import 'package:pokemon_finder/view_models/user.viewmodel.dart';
import 'package:pokemon_finder/views/home.view.dart';
import 'package:provider/provider.dart';
import 'package:smart_select/smart_select.dart';

class SelectFavouritePokemonView extends StatefulWidget {
  final String username;

  const SelectFavouritePokemonView({Key key, @required this.username})
      : super(key: key);

  @override
  _SelectFavouritePokemonViewState createState() =>
      _SelectFavouritePokemonViewState();
}

class _SelectFavouritePokemonViewState
    extends State<SelectFavouritePokemonView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _control = new UserController(repository: new UserRepository());

  // List<String> _types = [];
  List<String> _selected = [];
  List<PokemonType> _types = [];

  bool loadingList = false;

  List<Map<String, dynamic>> types = [
    {
      "thumbnailImage":
          "https://vortigo.blob.core.windows.net/files/pokemon/assets/normal.png",
      "name": "normal"
    },
    {
      "thumbnailImage":
          "https://vortigo.blob.core.windows.net/files/pokemon/assets/fighting.png",
      "name": "fighting"
    },
    {
      "thumbnailImage":
          "https://vortigo.blob.core.windows.net/files/pokemon/assets/flying.png",
      "name": "flying"
    },
    {
      "thumbnailImage":
          "https://vortigo.blob.core.windows.net/files/pokemon/assets/poison.png",
      "name": "poison"
    }
  ];

  @override
  Widget build(BuildContext context) {
    var userStore = Provider.of<UserStore>(context);
    var homeStore = Provider.of<HomeStore>(context);

    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/introduction_bg.jpg"),
                fit: BoxFit.fill)),
        child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_outlined),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Hello, ${widget.username}!",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "...now tell us which is your favorite Pokémon type:",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      loadingList
                          ? Column(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: CircularProgressIndicator(),
                                ),
                                Text(
                                  "Loading types...",
                                  style: TextStyle(fontSize: 16),
                                )
                              ],
                            )
                          : SmartSelect<String>.multiple(
                              title: 'Select one or more types',
                              placeholder: '',
                              value: _selected,
                              onChange: (state) {
                                _types.clear();
                                _selected = state.value;

                                setState(
                                  () => state.value.forEach(
                                    (element) => _types.add(
                                      PokemonType(
                                          thumbnailImage: element,
                                          name:
                                              state.valueTitle[_types.length]),
                                    ),
                                  ),
                                );
                              },
                              choiceItems: S2Choice.listFrom<String, Map>(
                                source: types,
                                value: (index, item) => item['thumbnailImage'],
                                title: (index, item) => item['name'],
                              ),
                              choiceTitleBuilder: (context, choice, value) {
                                return Container(
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(choice.value),
                                        backgroundColor: Colors.transparent,
                                      ),
                                      VerticalDivider(),
                                      Text(
                                        choice.title.toUpperCase(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                );
                              },
                              modalType: S2ModalType.bottomSheet,
                              modalConfirm: true,
                              tileBuilder: (context, state) {
                                return S2Tile.fromState(
                                  state,
                                  trailing: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                  ),
                                  isTwoLine: true,
                                  body: const Divider(
                                    indent: 10,
                                    thickness: 2,
                                    color: Colors.white,
                                  ),
                                );
                              }),
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 8,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () async {
                    if (_types.isNotEmpty) {
                      final UserViewModel newUser = UserViewModel(
                          username: widget.username, selectedTypes: _types);

                      try {
                        final bool valid = await _control.validateUser(newUser);
                        if (valid) {
                          userStore.setUser(newUser);
                          homeStore.updateTypesList(_types);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HomeView()),
                            (Route<dynamic> route) => false,
                          );
                        }
                      } catch (e) {
                        showSnackBar(
                            scaffoldKey: _scaffoldKey,
                            message: 'Something went wrong :(');
                        throw e.toString();
                      }
                    } else {
                      showSnackBar(
                          scaffoldKey: _scaffoldKey,
                          message: 'Please select a type of Pokemon.');
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void initState() {
    final _pokemonTypesController = PokemonTypesController();

    loadingList = true;

    _pokemonTypesController
        .convertPokemonTypeToMap()
        .then((value) {
          setState(() {
            types = value;
          });
        })
        .whenComplete(() => loadingList = false)
        .catchError((e) {
          print(e.toString());
        });

    super.initState();
  }

  void showSnackBar({@required scaffoldKey, @required String message}) {
    final snackBar =
        SnackBar(backgroundColor: Colors.red.shade900, content: Text(message));
    scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
