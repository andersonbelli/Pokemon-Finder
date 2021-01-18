import 'package:flutter/material.dart';
import 'package:pokemon_finder/models/pokemon_type.model.dart';

class PokemonTypesList extends StatelessWidget {
  const PokemonTypesList({
    Key key,
    @required this.pokemonData,
  }) : super(key: key);

  final List<PokemonType> pokemonData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: pokemonData.length,
      // itemCount: userStore.userViewModel.selectedTypes.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, i) {
        // var item = userStore.userViewModel.selectedTypes[i];
        var item = pokemonData[i];
        return SingleChildScrollView(
          child: Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(item.thumbnailImage),
                  ),
                ),
                Text(
                  item.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
