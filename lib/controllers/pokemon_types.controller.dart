import 'package:pokemon_finder/interfaces/pokemon.interface.dart';
import 'package:pokemon_finder/interfaces/pokemon_types.interface.dart';
import 'package:pokemon_finder/models/pokemon.model.dart';
import 'package:pokemon_finder/models/pokemon_type.model.dart';

import 'package:http/http.dart' as http;

import 'package:meta/meta.dart';
import 'package:pokemon_finder/services/api.service.dart';

class PokemonTypesController implements PokemonTypesInterface {
  final Api api = Api(client: http.Client());

  @override
  Future<List<PokemonType>> getPokemonTypesList() async {
    final List<PokemonType> listPokemonTypes = await api.getPokemonTypesList();

    return listPokemonTypes;
  }

  Future<List<Map<String, dynamic>>> convertPokemonTypeToMap() async {
    List<PokemonType> listToConvert = await getPokemonTypesList();

    List<Map<String, dynamic>> convertedList = [];

    listToConvert.forEach((element) {
      convertedList.add(element.toJson());
    });
    return convertedList;
  }
}
