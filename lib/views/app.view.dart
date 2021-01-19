import 'package:flutter/material.dart';
import 'package:pokemon_finder/views/home.view.dart';
import 'package:pokemon_finder/views/register.view.dart';
import 'package:provider/provider.dart';
import 'package:pokemon_finder/stores/user.store.dart';

class AppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userStore = Provider.of<UserStore>(context);

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/introduction_bg.jpg"),
              fit: BoxFit.fill)),
      child: userStore.userViewModel.username == null
          ? RegisterView()
          : HomeView(),
    );
  }
}
