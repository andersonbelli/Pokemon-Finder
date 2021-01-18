import 'package:pokemon_finder/models/pokemon.model.dart';

abstract class PokemonInterface {
  Future<List<Pokemon>> getPokemonList();
}
