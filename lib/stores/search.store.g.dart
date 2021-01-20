// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchStore on _SearchStore, Store {
  final _$searchIconAtom = Atom(name: '_SearchStore.searchIcon');

  @override
  IconData get searchIcon {
    _$searchIconAtom.reportRead();
    return super.searchIcon;
  }

  @override
  set searchIcon(IconData value) {
    _$searchIconAtom.reportWrite(value, super.searchIcon, () {
      super.searchIcon = value;
    });
  }

  final _$searchBoxWidthAtom = Atom(name: '_SearchStore.searchBoxWidth');

  @override
  double get searchBoxWidth {
    _$searchBoxWidthAtom.reportRead();
    return super.searchBoxWidth;
  }

  @override
  set searchBoxWidth(double value) {
    _$searchBoxWidthAtom.reportWrite(value, super.searchBoxWidth, () {
      super.searchBoxWidth = value;
    });
  }

  final _$_SearchStoreActionController = ActionController(name: '_SearchStore');

  @override
  void toggleSearchBox(bool toggle) {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.toggleSearchBox');
    try {
      return super.toggleSearchBox(toggle);
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSearchBoxIcon(IconData icon) {
    final _$actionInfo = _$_SearchStoreActionController.startAction(
        name: '_SearchStore.setSearchBoxIcon');
    try {
      return super.setSearchBoxIcon(icon);
    } finally {
      _$_SearchStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
searchIcon: ${searchIcon},
searchBoxWidth: ${searchBoxWidth}
    ''';
  }
}
