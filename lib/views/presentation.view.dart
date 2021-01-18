import 'package:flutter/material.dart';
import 'package:pokemon_finder/views/register.view.dart';

class PresentationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: Placeholder(
              color: Colors.red,
            ),
          ),
          RaisedButton(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Text(
              "Let's go!",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            color: Colors.pinkAccent.shade700,
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => RegisterView()));
            },
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3,
            child: Placeholder(
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
