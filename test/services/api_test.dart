import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:matcher/matcher.dart';
import 'package:mockito/mockito.dart';
import 'package:pokemon_finder/errors/failure.dart';
import 'package:pokemon_finder/models/pokemon_list.model.dart';
import 'package:pokemon_finder/models/pokemon_type.model.dart';
import 'package:pokemon_finder/models/pokemon_type_list.model.dart';
import 'package:pokemon_finder/services/api.service.dart';

import '../raw_data/raw_data_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  MockHttpClient mockHttpClient;
  Api dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = Api(client: mockHttpClient);
  });

  group('fetchPokemonList', () {
    final tPokemonListModel =
        PokemonList.fromJson(json.decode(readRawFile('pokemon_list.json')));

    test(
        "Should return the Pokemon List and first element must be equal to first element on json",
        () async {
      when(mockHttpClient.get(any)).thenAnswer(
          (_) async => http.Response(readRawFile('pokemon_list.json'), 200));

      final PokemonList result = await dataSource.getPokemonList();

      verify(mockHttpClient.get(
          POKEMON_URL)); // * Verify if the "client" was called using "get" method and to URL "Pokemon_URL"
      expect(result.pokemonList.first.id,
          equals(tPokemonListModel.pokemonList.first.id));
    });

    test("Should throw a ServerFailure when the statusCode isn't 200",
        () async {
      when(mockHttpClient.get(POKEMON_URL))
          .thenThrow(ServerFailure(message: "Error message"));

      final call = dataSource.getPokemonList;

      expect(() async => await call(), throwsA(TypeMatcher<ServerFailure>()));
    });
  });

  group('fetchPokemonTypesList', () {
    final tPokemonListTypeModel = PokemonTypesList.fromJson(
        json.decode(readRawFile('pokemon_list_type.json'))["results"]);

    test(
        "Should return the Pokemon List and first element must be equal to first element on json",
        () async {
      when(mockHttpClient.get(any)).thenAnswer((_) async =>
          http.Response(readRawFile('pokemon_list_type.json'), 200));

      final PokemonTypesList result = await dataSource.getPokemonTypesList();

      verify(mockHttpClient.get(
          POKEMON_TYPES_URL)); // * Verify if the "client" was called using "get" method and to URL "Pokemon_URL"
      expect(result.pokemonTypesList.first.name,
          equals(tPokemonListTypeModel.pokemonTypesList.first.name));
    });

    test("Should throw a ServerFailure when the statusCode isn't 200",
        () async {
      when(mockHttpClient.get(POKEMON_TYPES_URL))
          .thenThrow(ServerFailure(message: "Error message"));

      final call = dataSource.getPokemonTypesList;

      expect(() async => await call(), throwsA(TypeMatcher<ServerFailure>()));
    });
  });
}
