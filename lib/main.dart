import 'package:flutter/material.dart';
import 'package:pokemon_finder/stores/home.store.dart';
import 'package:pokemon_finder/stores/search.store.dart';
import 'package:pokemon_finder/stores/user.store.dart';
import 'package:pokemon_finder/views/app.view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SearchStore>.value(value: SearchStore()),
        Provider<UserStore>.value(value: UserStore()),
        Provider<HomeStore>.value(value: HomeStore()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pokemon Finder',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/introduction_bg.jpg"),
                  fit: BoxFit.fill)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppView(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
