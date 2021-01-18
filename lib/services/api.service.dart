import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:pokemon_finder/errors/failure.dart';
import 'package:pokemon_finder/interfaces/pokemon.interface.dart';
import 'package:pokemon_finder/interfaces/pokemon_types.interface.dart';
import 'package:pokemon_finder/models/pokemon.model.dart';
import 'package:pokemon_finder/models/pokemon_type.model.dart';

const BASE_URL = "https://vortigo.blob.core.windows.net/files/pokemon/data";
const POKEMON_URL = "$BASE_URL/pokemons.json";
const POKEMON_TYPES_URL = "$BASE_URL/types.json";

class Api implements PokemonInterface, PokemonTypesInterface {
  final http.Client client;

  Api({@required this.client});

  @override
  Future<List<Pokemon>> getPokemonList() async {
    var response = await client.get(POKEMON_URL);
    if (response.statusCode == 200) {
      final List parsed = json.decode(response.body);
      List<Pokemon> list =
          parsed.map((data) => Pokemon.fromJson(data)).toList();

      return list;
    } else {
      throw ServerFailure();
    }
  }

  @override
  Future<List<PokemonType>> getPokemonTypesList() async {
    var response = await client.get(POKEMON_TYPES_URL);

    final List parsed = json.decode(response.body);
    List<PokemonType> list =
        parsed.map((data) => PokemonType.fromJson(data)).toList();

    return list;
  }
}
