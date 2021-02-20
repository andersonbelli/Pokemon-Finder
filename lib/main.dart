import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokemon_finder/stores/home.store.dart';
import 'package:pokemon_finder/stores/search.store.dart';
import 'package:pokemon_finder/stores/user.store.dart';
import 'package:pokemon_finder/views/presentation.view.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

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
          // primarySwatch: Colors.green,
          primaryColor: Color.fromRGBO(42, 198, 161, 1),
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
                child: PresentationView(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
