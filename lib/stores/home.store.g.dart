// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStore, Store {
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

  final _$_HomeStoreActionController = ActionController(name: '_HomeStore');

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
  String toString() {
    return '''
currentList: ${currentList}
    ''';
  }
}
