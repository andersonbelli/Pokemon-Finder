import 'package:http/http.dart' as http;
import 'package:pokemon_finder/interfaces/pokemon_types.interface.dart';
import 'package:pokemon_finder/models/pokemon_type.model.dart';
import 'package:pokemon_finder/models/pokemon_type_list.model.dart';
import 'package:pokemon_finder/services/api.service.dart';

class PokemonTypesController implements PokemonTypesInterface {
  final Api api = Api(client: http.Client());

  @override
  Future<PokemonTypesList> getPokemonTypesList() async {
    final PokemonTypesList listPokemonTypes = await api.getPokemonTypesList();

    return listPokemonTypes;
  }

  // @override
  // Future<List<PokemonType>> getPokemonTypesList() async {
  //   final List<PokemonType> listPokemonTypes = await api.getPokemonTypesList();
  //
  //   return listPokemonTypes;
  // }

  Future<List<Map<String, dynamic>>> convertPokemonTypeToMap() async {
    PokemonTypesList listToConvert = await getPokemonTypesList();

    List<Map<String, dynamic>> convertedList = [];

    listToConvert.pokemonTypesList.forEach((element) {
      convertedList.add(element.toJson());
    });
    return convertedList;
  }
}
