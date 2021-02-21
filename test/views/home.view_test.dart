import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_finder/models/pokemon_list.model.dart';
import 'package:pokemon_finder/models/pokemon_type.model.dart';
import 'package:pokemon_finder/models/pokemon_type_list.model.dart';
import 'package:pokemon_finder/stores/home.store.dart';
import 'package:pokemon_finder/stores/search.store.dart';
import 'package:pokemon_finder/views/home.view.dart';
import 'package:provider/provider.dart';

import '../raw_data/raw_data_reader.dart';

Widget createHomeScreen(HomeStore homeStore) => MultiProvider(
      providers: [
        Provider<SearchStore>(create: (context) => SearchStore()),
        Provider<HomeStore>(create: (context) => homeStore),
      ],
      child: Builder(builder: (_) => MaterialApp(home: HomeView())),
    );

void main() {
  // * Necessary to handle HTTP error that "Image.Network" throws
  setUpAll(() => HttpOverrides.global = null);

  final tPokemonListModel =
      PokemonList.fromJson(json.decode(readRawFile('pokemon_list.json')));
  final tPokemonListTypeModel = PokemonTypesList.fromJson(
      json.decode(readRawFile('pokemon_list_type.json'))["results"]);

  testWidgets(
      "Should sort list in reverse alphabetic order on click in 'name' button",
      (WidgetTester tester) async {
    HttpOverrides.runZoned(() async {
      final _homeStore = HomeStore();
      _homeStore.currentList = tPokemonListModel.pokemonList;
      _homeStore.typesList = tPokemonListTypeModel.pokemonTypesList;

      await tester.pumpWidget(createHomeScreen(_homeStore));

      await tester.pump(Duration(seconds: 1));

      final buttonNameOrderFinder = find.byKey(ValueKey("nameOrderButton"));
      expect(find.byKey(ValueKey("nameOrderButton")), findsOneWidget);

      expect(_homeStore.currentList.first.name,
          tPokemonListModel.pokemonList.first.name);

      await tester.tap(buttonNameOrderFinder);

      expect(_homeStore.currentList.first.name,
          tPokemonListModel.pokemonList.last.name);
    });
  });
}
