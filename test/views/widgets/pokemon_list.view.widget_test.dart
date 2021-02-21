import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokemon_finder/models/pokemon_list.model.dart';
import 'package:pokemon_finder/stores/home.store.dart';
import 'package:pokemon_finder/views/widgets/pokemon_list.view.widget.dart';
import 'package:provider/provider.dart';

import '../../raw_data/raw_data_reader.dart';

Widget createPokemonListWidget(HomeStore homeStore) => Provider<HomeStore>(
      create: (context) => homeStore,
      child: MaterialApp(
        home: PokemonListWidget(),
      ),
    );

void main() {
  // * Necessary to handle HTTP error that "Image.Network" throws
  setUpAll(() => HttpOverrides.global = null);

  final tPokemonListModel =
      PokemonList.fromJson(json.decode(readRawFile('pokemon_list.json')));
  final firstItemNameFromJson = tPokemonListModel.pokemonList.first.name;

  testWidgets('First item should be equal to first item in list',
      (WidgetTester tester) async {
    // * Necessary to handle HTTP error that "Image.Network" throws
    HttpOverrides.runZoned(
      () async {
        final _homeStore = HomeStore();
        _homeStore.currentList = tPokemonListModel.pokemonList;

        await tester.pumpWidget(createPokemonListWidget(_homeStore));

        final listFinder = find.byType(ListView);
        final firstItemNameFinder = find.text(firstItemNameFromJson);

        expect(listFinder, findsOneWidget);
        expect(firstItemNameFinder, findsOneWidget);

        Text firstItemNameText = tester.firstWidget(firstItemNameFinder);
        expect(firstItemNameText.data, equals(firstItemNameFromJson));
        expect(firstItemNameText.style.fontSize, equals(18));
      },
    );
  });
}
