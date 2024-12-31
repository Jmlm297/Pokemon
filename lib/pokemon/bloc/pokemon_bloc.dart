import 'package:flutter_bloc/flutter_bloc.dart';
import '../api/servicesPokemon.dart';
import 'pokemon_event.dart';
import 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonService _pokemonService;

  PokemonBloc(this._pokemonService) : super(PokemonInitial()) {
    on<LoadPokemonList>(_onLoadPokemonList);
    on<LoadPokemonDetails>(_onLoadPokemonDetails);
  }

  Future<void> _onLoadPokemonList(
    LoadPokemonList event,
    Emitter<PokemonState> emit,
  ) async {
    try {
      emit(PokemonLoading());
      final pokemons = await _pokemonService.getPokemonList(
        limit: event.limit,
        offset: event.offset,
      );
      emit(PokemonListLoaded(
        pokemons,
        offset: event.offset,
        limit: event.limit,
      ));
    } catch (e) {
      emit(PokemonError(e.toString()));
    }
  }

  Future<void> _onLoadPokemonDetails(
    LoadPokemonDetails event,
    Emitter<PokemonState> emit,
  ) async {
    try {
      emit(PokemonLoading());
      final pokemon = await _pokemonService.getPokemonDetails(event.nameOrId);
      emit(PokemonDetailsLoaded(pokemon));
    } catch (e) {
      emit(PokemonError(e.toString()));
    }
  }
}
