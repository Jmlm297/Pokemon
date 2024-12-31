import '../models/pokemon.dart';

abstract class PokemonState {}

class PokemonInitial extends PokemonState {}

class PokemonLoading extends PokemonState {}

class PokemonListLoaded extends PokemonState {
  final List<Pokemon> pokemons;
  final int offset;
  final int limit;

  PokemonListLoaded(
    this.pokemons, {
    this.offset = 0,
    this.limit = 20,
  });
}

class PokemonDetailsLoaded extends PokemonState {
  final Pokemon pokemon;

  PokemonDetailsLoaded(this.pokemon);
}

class PokemonError extends PokemonState {
  final String message;

  PokemonError(this.message);
}
