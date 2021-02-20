import 'package:pokemon_finder/models/pokemon_type.model.dart';
import 'package:pokemon_finder/models/pokemon_type_list.model.dart';

abstract class PokemonTypesInterface {
  // Future<List<PokemonType>> getPokemonTypesList();
  Future<PokemonTypesList> getPokemonTypesList();
}
