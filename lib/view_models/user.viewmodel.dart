import 'package:pokemon_finder/models/pokemon_type.model.dart';

class UserViewModel {
  String username;
  List<PokemonType> selectedTypes;

  UserViewModel({this.username, this.selectedTypes});
}
