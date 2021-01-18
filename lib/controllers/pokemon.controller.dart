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

  Future<List<PokemonType>> filterBySelectedTypes(
      List<PokemonType> selectedTypes) async {}
}
