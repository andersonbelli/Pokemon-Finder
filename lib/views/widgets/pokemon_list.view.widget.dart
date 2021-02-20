import 'dart:math';

import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokemon_finder/models/pokemon.model.dart';
import 'package:pokemon_finder/stores/home.store.dart';
import 'package:provider/provider.dart';

class PokemonListWidget extends StatefulWidget {
  @override
  _PokemonListWidgetState createState() => _PokemonListWidgetState();
}

class _PokemonListWidgetState extends State<PokemonListWidget> {
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
                          // color: Colors.green,
                          child: Blob.fromID(
                            // id: ['9-7-3291'],
                            id: [
                              '9-7-' + new Random().nextInt(9999).toString()
                            ],
                            size: 85,
                            styles: BlobStyles(
                              // fillType: BlobFillType.stroke,
                              gradient: LinearGradient(
                                colors: [
                                  // Color(0xffe96443).withOpacity(0.5),
                                  // Color(0xff904e95).withOpacity(0.5),
                                  Color(0xffc2185b).withOpacity(0.5),
                                  Color(0xff2ac6a1).withOpacity(0.5)
                                ],
                              ).createShader(Rect.fromLTRB(0, 0, 65, 65)),
                            ),
                          ),
                        ),
                        Container(
                          height: 80,
                          child: Image.network(
                            item.thumbnailImage,
                            alignment: Alignment.center,
                            fit: BoxFit.cover,
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

            // return ListTile(
            //   leading: CircleAvatar(
            //     // backgroundColor: Colors.blue.shade100,
            //     backgroundColor: Colors.transparent,
            //     maxRadius: 23,
            //     backgroundImage: NetworkImage(item.thumbnailImage),
            //   ),
            //   title: Text(
            //     item.name,
            //     style: TextStyle(fontSize: 18),
            //   ),
            // );
          }),
    );
  }
}
