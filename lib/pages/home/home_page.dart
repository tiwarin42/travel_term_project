import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_term_project/pages/event/event_page.dart';
import 'package:travel_term_project/pages/place_search/place_search_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://drive.google.com/uc?export=view&id=1wJ5qnrrqMJHY3sBUktZTHoWm_GB2z-Np"),
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), BlendMode.srcATop),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    child: Text(
                  'Tourism in Thailand',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.prompt(
                      fontSize: 60.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                )),
                SizedBox(
                  height: 40.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF03878F),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  width: 250.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 5.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, PlaceSearchPage.routeName,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            'search',
                            style: GoogleFonts.prompt(
                              color: Colors.white,
                              fontSize: 23.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF2B3D5B),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  // width: 150.0,
                  width: 250.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, EventPage.routeName,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.event_available_outlined,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            'Event',
                            style: GoogleFonts.prompt(
                              color: Colors.white,
                              fontSize: 23.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
