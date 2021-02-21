import 'dart:math';

import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokemon_finder/models/pokemon.model.dart';
import 'package:pokemon_finder/stores/home.store.dart';
import 'package:provider/provider.dart';

class PokemonListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var homeStore = Provider.of<HomeStore>(context);

    return Observer(
      builder: (_) => ListView.builder(
          shrinkWrap: true,
          itemCount: homeStore.currentList.length,
          itemBuilder: (context, i) {
            Pokemon item = homeStore.currentList[i];

            return Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                    flex: 4,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          child: Blob.fromID(
                            id: [
                              '9-7-' + new Random().nextInt(9999).toString()
                            ],
                            size: 85,
                            styles: BlobStyles(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xffc2185b).withOpacity(0.5),
                                  Color(0xff2ac6a1).withOpacity(0.5)
                                ],
                              ).createShader(Rect.fromLTRB(0, 0, 65, 65)),
                            ),
                          ),
                        ),
                        Container(
                          height: 80,
                          child: FadeInImage.assetNetwork(
                            placeholder: "assets/picachu.png",
                            image: item.thumbnailImage,
                          ),
                        ),
                      ],
                    )),
                Expanded(
                  flex: 10,
                  child: Text(
                    item.name,
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            );
          }),
    );
  }
}
