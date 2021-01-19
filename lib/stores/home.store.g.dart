// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStore, Store {
  final _$loadedListAtom = Atom(name: '_HomeStore.loadedList');

  @override
  List<Pokemon> get loadedList {
    _$loadedListAtom.reportRead();
    return super.loadedList;
  }

  @override
  set loadedList(List<Pokemon> value) {
    _$loadedListAtom.reportWrite(value, super.loadedList, () {
      super.loadedList = value;
    });
  }

  final _$currentListAtom = Atom(name: '_HomeStore.currentList');

  @override
  List<Pokemon> get currentList {
    _$currentListAtom.reportRead();
    return super.currentList;
  }

  @override
  set currentList(List<Pokemon> value) {
    _$currentListAtom.reportWrite(value, super.currentList, () {
      super.currentList = value;
    });
  }

  final _$typesListAtom = Atom(name: '_HomeStore.typesList');

  @override
  List<PokemonType> get typesList {
    _$typesListAtom.reportRead();
    return super.typesList;
  }

  @override
  set typesList(List<PokemonType> value) {
    _$typesListAtom.reportWrite(value, super.typesList, () {
      super.typesList = value;
    });
  }

  final _$listNameAtom = Atom(name: '_HomeStore.listName');

  @override
  String get listName {
    _$listNameAtom.reportRead();
    return super.listName;
  }

  @override
  set listName(String value) {
    _$listNameAtom.reportWrite(value, super.listName, () {
      super.listName = value;
    });
  }

  final _$sortIconAtom = Atom(name: '_HomeStore.sortIcon');

  @override
  IconData get sortIcon {
    _$sortIconAtom.reportRead();
    return super.sortIcon;
  }

  @override
  set sortIcon(IconData value) {
    _$sortIconAtom.reportWrite(value, super.sortIcon, () {
      super.sortIcon = value;
    });
  }

  final _$_HomeStoreActionController = ActionController(name: '_HomeStore');

  @override
  void updateLoadedList(List<Pokemon> updatedList) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.updateLoadedList');
    try {
      return super.updateLoadedList(updatedList);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateCurrentList(List<Pokemon> updatedList) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.updateCurrentList');
    try {
      return super.updateCurrentList(updatedList);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateTypesList(List<PokemonType> updatedList) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.updateTypesList');
    try {
      return super.updateTypesList(updatedList);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeListName(String newName) {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.changeListName');
    try {
      return super.changeListName(newName);
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSortIcon() {
    final _$actionInfo = _$_HomeStoreActionController.startAction(
        name: '_HomeStore.changeSortIcon');
    try {
      return super.changeSortIcon();
    } finally {
      _$_HomeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loadedList: ${loadedList},
currentList: ${currentList},
typesList: ${typesList},
listName: ${listName},
sortIcon: ${sortIcon}
    ''';
  }
}
