import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/pokemon/api/servicesPokemon.dart';
import 'package:pokemon/pokemon/bloc/pokemon_bloc.dart';
import 'package:pokemon/pokemon/views/homePokemon.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => PokemonBloc(PokemonService()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: HomePokemon(),
        ),
      ),
    );
  }
}
