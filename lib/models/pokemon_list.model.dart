import 'package:pokemon_finder/models/pokemon.model.dart';

class PokemonList {
  final List<Pokemon> pokemonList;

  PokemonList({
    this.pokemonList,
  });

  factory PokemonList.fromJson(List<dynamic> json) {
    List<Pokemon> pokemonList = new List<Pokemon>();

    pokemonList = json.map((e) => Pokemon.fromJson(e)).toList();

    return new PokemonList(
      pokemonList: pokemonList,
    );
  }
}
