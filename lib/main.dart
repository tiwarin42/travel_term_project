import 'package:flutter/material.dart';
import 'package:travel_term_project/pages/event/event_page.dart';
import 'package:travel_term_project/pages/home/home_page.dart';
import 'package:travel_term_project/pages/place_search/list_place_search.dart';
import 'package:travel_term_project/pages/place_search/place_search_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        HomePage.routeName : (context) => const HomePage(),
        PlaceSearchPage.routeName: (context) => const PlaceSearchPage(),
        EventPage.routeName: (context) => const EventPage(),
      },
      initialRoute: HomePage.routeName,
    );
  }
}
