import 'package:flutter/material.dart';
import 'package:pokemon_finder/models/pokemon_type.model.dart';

class PokemonTypesListWidget extends StatelessWidget {
  const PokemonTypesListWidget({
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
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  child: CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(item.thumbnailImage),
                  ),
                ),
                SizedBox(height: 5),
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
