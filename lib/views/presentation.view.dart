import 'package:flutter/material.dart';
import 'package:pokemon_finder/views/app.view.dart';
import 'package:pokemon_finder/views/register.view.dart';

class PresentationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: Image.asset(
              "assets/PokemonLogo.png",
              scale: 6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36.0),
            child: RaisedButton(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.transparent)),
              child: Text(
                "Let's go!",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              color: Colors.pinkAccent.shade700,
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => AppView()));
              },
            ),
          ),
          Container(
            transform: Matrix4.translationValues(70, 50, 0),
            height: MediaQuery.of(context).size.height / 3,
            child: Image.asset(
              "assets/picachu.png",
              alignment: Alignment.bottomRight,
            ),
          ),
        ],
      ),
    );
  }
}
