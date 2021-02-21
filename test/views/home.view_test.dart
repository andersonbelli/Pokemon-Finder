import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_finder/models/pokemon_list.model.dart';
import 'package:pokemon_finder/models/pokemon_type.model.dart';
import 'package:pokemon_finder/models/pokemon_type_list.model.dart';
import 'package:pokemon_finder/stores/home.store.dart';
import 'package:pokemon_finder/stores/search.store.dart';
import 'package:pokemon_finder/views/home.view.dart';
import 'package:provider/provider.dart';

import '../raw_data/raw_data_reader.dart';

Widget createHomeScreen(HomeStore homeStore, SearchStore searchStore) {
  return MultiProvider(
    providers: [
      Provider<SearchStore>(create: (context) => searchStore),
      Provider<HomeStore>(create: (context) => homeStore),
    ],
    child: Builder(builder: (_) => MaterialApp(home: HomeView())),
  );
}

void main() {
  // * Necessary to handle HTTP error that "Image.Network" throws
  setUpAll(() => HttpOverrides.global = null);

  final tPokemonListModel =
      PokemonList.fromJson(json.decode(readRawFile('pokemon_list.json')));
  final tPokemonListTypeModel = PokemonTypesList.fromJson(
      json.decode(readRawFile('pokemon_list_type.json'))["results"]);

  final _homeStore = HomeStore();
  final _searchStore = SearchStore();

  void searchInitialProcess(WidgetTester tester) async {
    _homeStore.currentList = tPokemonListModel.pokemonList;
    _homeStore.loadedList = tPokemonListModel.pokemonList;

    await tester.pumpWidget(createHomeScreen(_homeStore, _searchStore));
    await tester.pump(Duration(seconds: 1));

    expect(_homeStore.currentList.first.abilities.first,
        equals(tPokemonListModel.pokemonList.first.abilities.first));

    expect(_searchStore.searchBoxWidth, equals(0));
    expect(_searchStore.searchIcon, Icons.search);
  }

  HttpOverrides.runZoned(() async {
    group("Happy paths tests", () {
      testWidgets(
          "Should sort list in reverse alphabetic order on click in 'name' button",
          (WidgetTester tester) async {
        _homeStore.currentList = tPokemonListModel.pokemonList;
        _homeStore.typesList = tPokemonListTypeModel.pokemonTypesList;

        await tester.pumpWidget(createHomeScreen(_homeStore, _searchStore));
        await tester.pump(Duration(seconds: 1));

        final buttonNameOrderFinder =
            find.byKey(ValueKey("nameOrderButtonKey"));
        expect(buttonNameOrderFinder, findsOneWidget);

        expect(_homeStore.currentList.first.name,
            equals(tPokemonListModel.pokemonList.first.name));

        await tester.tap(buttonNameOrderFinder);

        expect(_homeStore.currentList.first.name,
            equals(tPokemonListModel.pokemonList.last.name));
      });

      testWidgets(
          "Should search a pokemon based on his abilities and update list with return",
          (WidgetTester tester) async {
        await searchInitialProcess(tester);

        final searchIconButton = find.byIcon(_searchStore.searchIcon);
        await tester.tap(searchIconButton);

        expect(_searchStore.searchBoxWidth, isNot(0));
        expect(_searchStore.searchIcon, Icons.search);

        await tester.pump();

        final searchTextFieldFinder =
            find.byKey(ValueKey("searchTextFieldKey"));
        expect(searchTextFieldFinder, findsOneWidget);

        await tester.enterText(searchTextFieldFinder, "Thick Fat");
        TextField search = tester.firstWidget(searchTextFieldFinder);
        expect(search.controller.text, equals("Thick Fat"));

        expect(_searchStore.searchIcon, Icons.search);
        await tester.tap(searchIconButton);
        expect(_searchStore.searchIcon, Icons.cancel);

        await tester.pump();

        final listNameTextFinder = find.byKey(ValueKey("listNameTextKey"));
        Text firstItemNameText = tester.firstWidget(listNameTextFinder);
        expect(firstItemNameText.data, equals("Search: Thick Fat"));

        expect(
            _homeStore.currentList.first.abilities.first, equals("Thick Fat"));
        expect(_searchStore.searchIcon, Icons.cancel);
      });
    });

    group("Wrong path tests", () {
      testWidgets(
          "Should search a pokemon based on his abilities and find none",
          (WidgetTester tester) async {
        await searchInitialProcess(tester);

        final searchIconButton = find.byIcon(_searchStore.searchIcon);
        await tester.tap(searchIconButton);

        expect(_searchStore.searchBoxWidth, isNot(0));
        expect(_searchStore.searchIcon, Icons.search);

        await tester.pump();

        final searchTextFieldFinder =
            find.byKey(ValueKey("searchTextFieldKey"));
        expect(searchTextFieldFinder, findsOneWidget);

        await tester.enterText(searchTextFieldFinder, "Error on search");
        TextField search = tester.firstWidget(searchTextFieldFinder);
        expect(search.controller.text, equals("Error on search"));

        expect(_searchStore.searchIcon, Icons.search);
        await tester.tap(searchIconButton);
        expect(_searchStore.searchIcon, Icons.search);

        await tester.pump();

        expect(find.text("Sorry, nothing was found 😔"), findsOneWidget);
        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text("Pokemon"), findsOneWidget);
        expect(_searchStore.searchBoxWidth, equals(0));
        await tester.pump();

        final listNameTextFinder = find.byKey(ValueKey("listNameTextKey"));
        Text firstItemNameText = tester.firstWidget(listNameTextFinder);
        expect(firstItemNameText.data, equals("Pokemon"));

        expect(
            _homeStore.currentList.first.abilities.first, equals("Overgrow"));
        expect(_searchStore.searchIcon, Icons.search);
      });
    });
  });
}
