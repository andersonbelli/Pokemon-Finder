import 'package:pokemon_finder/models/pokemon_list.model.dart';

abstract class PokemonInterface {
  Future<PokemonList> getPokemonList();
}
