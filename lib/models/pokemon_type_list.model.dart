import 'package:pokemon_finder/models/pokemon.model.dart';
import 'package:pokemon_finder/models/pokemon_type.model.dart';

class PokemonTypesList {
  final List<PokemonType> pokemonTypesList;

  PokemonTypesList({
    this.pokemonTypesList,
  });

  factory PokemonTypesList.fromJson(List<dynamic> json) {
    List<PokemonType> pokemonTypesList = new List<PokemonType>();

    pokemonTypesList = json.map((e) => PokemonType.fromJson(e)).toList();

    return new PokemonTypesList(
      pokemonTypesList: pokemonTypesList,
    );
  }
}
