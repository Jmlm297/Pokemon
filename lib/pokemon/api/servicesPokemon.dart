//import 'dart:convert';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/pokemon.dart';

class PokemonService {
  final String baseUrl = 'https://pokeapi.co/api/v2';

  Future<List<Pokemon>> getPokemonList({int limit = 20, int offset = 0}) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/pokemon?limit=$limit&offset=$offset'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> results = data['results'];

        // Obtener los detalles completos de cada Pokemon
        List<Pokemon> pokemons = [];
        for (var pokemonData in results) {
          final detailsResponse = await http.get(Uri.parse(pokemonData['url']));
          if (detailsResponse.statusCode == 200) {
            final pokemonDetails = json.decode(detailsResponse.body);
            pokemons.add(Pokemon.fromJson(pokemonDetails));
          }
        }
        return pokemons;
      } else {
        throw Exception('Error al cargar la lista de Pokémon');
      }
    } catch (e) {
      throw Exception('Error en la conexión: $e');
    }
  }

  Future<Pokemon> getPokemonDetails(String nameOrId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/pokemon/$nameOrId'),
      );

      if (response.statusCode == 200) {
        final pokemonData = json.decode(response.body);
        return Pokemon.fromJson(pokemonData);
      } else {
        throw Exception('Error al cargar los detalles del Pokémon');
      }
    } catch (e) {
      throw Exception('Error en la conexión: $e');
    }
  }
}
