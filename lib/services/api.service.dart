import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:pokemon_finder/errors/failure.dart';
import 'package:pokemon_finder/interfaces/pokemon.interface.dart';
import 'package:pokemon_finder/interfaces/pokemon_types.interface.dart';
import 'package:pokemon_finder/models/pokemon_list.model.dart';
import 'package:pokemon_finder/models/pokemon_type.model.dart';
import 'package:pokemon_finder/models/pokemon_type_list.model.dart';

const BASE_URL = "https://vortigo.blob.core.windows.net/files/pokemon/data";
const POKEMON_URL = "$BASE_URL/pokemons.json";
const POKEMON_TYPES_URL = "$BASE_URL/types.json";

class Api implements PokemonInterface, PokemonTypesInterface {
  final http.Client client;

  Api({@required this.client});

  @override
  Future<PokemonList> getPokemonList() async {
    var response = await client.get(POKEMON_URL);

    if (response.statusCode == 200) {
      final List parsed = json.decode(response.body);

      PokemonList list = PokemonList.fromJson(parsed);

      return list;
    } else {
      throw ServerFailure(message: _getMessage(response.statusCode));
    }
  }

  @override
  Future<PokemonTypesList> getPokemonTypesList() async {
    var response = await client.get(POKEMON_TYPES_URL);

    if (response.statusCode == 200) {
      Map<String, dynamic> rawJson = json.decode(response.body);

      return PokemonTypesList.fromJson(json.decode(response.body)["results"]);
    } else {
      throw ServerFailure(message: _getMessage(response.statusCode));
    }
  }

  String _getMessage(int statusCode) {
    if (_statusCodeResponses.containsKey(statusCode)) {
      return _statusCodeResponses[statusCode];
    }
    return 'Unknown error';
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'There was an error recovering the list of Pokemons\n😔',
    401: 'Ops, you are not authorized to do that.',
    404: 'Something went wrong recovering the list\n😔'
  };
}
