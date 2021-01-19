import 'dart:convert';

import 'package:pokemon_finder/interfaces/pokemon.interface.dart';
import 'package:pokemon_finder/models/pokemon.model.dart';
import 'package:pokemon_finder/models/pokemon_type.model.dart';

import 'package:http/http.dart' as http;

import 'package:meta/meta.dart';
import 'package:pokemon_finder/services/api.service.dart';

class PokemonController implements PokemonInterface {
  final Api api = Api(client: http.Client());

  @override
  Future<List<Pokemon>> getPokemonList() async {
    final List<Pokemon> listPokemon = await api.getPokemonList();

    return listPokemon;
  }

  Future<List<Pokemon>> loadHomeList(
      List<PokemonType> selectedTypes, bool reversed) async {
    return sortListByName(await filterBySelectedTypes(selectedTypes), reversed);
  }

  Future<List<Pokemon>> filterBySelectedTypes(
      List<PokemonType> selectedTypes) async {
    List<Pokemon> listToConvert = await getPokemonList();

    // TODO improve performance of this method

    List<Pokemon> resultFilter = listToConvert.where((element) {
      bool selected = false;

      for (int i = 0; i < selectedTypes.length; i++) {
        selected = element.type
            .toString()
            .toLowerCase()
            .contains(selectedTypes[i].name.toLowerCase());
      }

      return selected;
    }).toList();

    return resultFilter;
  }

  List<Pokemon> filterListToSearchedValue(
      String query, List<Pokemon> listToSearch) {
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

  List<Pokemon> sortListByName(List<Pokemon> listToSort, bool reversed) {
    listToSort.sort((a, b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });

    if (reversed) {
      return listToSort;
    } else {
      return listToSort.reversed.toList();
    }
  }
}
