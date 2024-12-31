abstract class PokemonEvent {}

class LoadPokemonList extends PokemonEvent {
  final int limit;
  final int offset;

  LoadPokemonList({this.limit = 20, this.offset = 0});
}

class LoadPokemonDetails extends PokemonEvent {
  final String nameOrId;

  LoadPokemonDetails(this.nameOrId);
}
