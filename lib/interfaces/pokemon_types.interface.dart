import 'package:pokemon_finder/models/pokemon_type.model.dart';

abstract class PokemonTypesInterface {
  Future<List<PokemonType>> getPokemonTypesList();
}
