import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pokemon_finder/models/pokemon.model.dart';
import 'package:pokemon_finder/models/pokemon_type.model.dart';

part 'home.store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

//  flutter packages pub run build_runner clean
//  flutter packages pub run build_runner build --delete-conflicting-outputs
abstract class _HomeStore with Store {
  @observable
  List<Pokemon> loadedList = new List<Pokemon>().asObservable();

  @observable
  List<Pokemon> currentList = new List<Pokemon>().asObservable();

  @action
  void updateCurrentList(List<Pokemon> updatedList) {
    this.currentList = updatedList;
  }

  @observable
  List<PokemonType> typesList = new List<PokemonType>().asObservable();

  @action
  void updateTypesList(List<PokemonType> updatedList) {
    this.typesList = updatedList;
  }

  @observable
  String listName = "Pokemon";

  @action
  void changeListName(String newName) {
    this.listName = newName;
  }

  @observable
  IconData sortIcon = Icons.arrow_upward;

  @action
  void changeSortIcon() {
    this.sortIcon == Icons.arrow_upward
        ? this.sortIcon = Icons.arrow_downward
        : this.sortIcon = Icons.arrow_upward;
  }
}
