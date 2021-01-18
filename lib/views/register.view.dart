import 'package:flutter/material.dart';
import 'package:pokemon_finder/views/select_favourite_pokemon.view.dart';

class RegisterView extends StatelessWidget {
  final TextEditingController usernameController =
      TextEditingController(text: "Anderson");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: Text(
                "Let's meet each other first?",
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "First we need to know your name...",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  TextField(
                    controller: usernameController,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height / 8,
            child: IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                if (usernameController.text.isNotEmpty)
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectFavouritePokemonView(
                              username: usernameController.text)));
              },
            ),
          ),
        ],
      ),
    );
  }
}
