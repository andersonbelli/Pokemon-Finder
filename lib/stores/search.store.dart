import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pokemon_finder/models/pokemon.model.dart';

part 'search.store.g.dart';

class SearchStore = _SearchStore with _$SearchStore;

//  flutter packages pub run build_runner clean
//  flutter packages pub run build_runner build --delete-conflicting-outputs
abstract class _SearchStore with Store {
  @observable
  IconData searchIcon = Icons.search;

  @observable
  double searchBoxWidth = 0;

  @observable
  List<Pokemon> searchedResult = new List<Pokemon>().asObservable();

  @action
  void setSearchBoxWidth() {
    this.searchBoxWidth == 0
        ? this.searchBoxWidth = double.maxFinite
        : this.searchBoxWidth = 0;
  }

  @action
  void setSearchBoxIcon(IconData icon) {
    this.searchIcon = icon;
  }

  @action
  void setSearchedResult(List<Pokemon> result) {
    this.searchedResult = result;
  }
}