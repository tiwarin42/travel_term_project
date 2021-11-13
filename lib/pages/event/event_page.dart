import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_term_project/models/event.dart';
import 'package:travel_term_project/pages/event/detail_event_page.dart';
import 'package:travel_term_project/services/api.dart';

class EventPage extends StatefulWidget {
  static const routeName = '/recommend_page';

  const EventPage({Key? key}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  late Future<List<Event>> _futureEvent;
  var _lat;
  var _long;
  var _location;
  bool _loading = false;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();

    _determinePosition().then((value) {
      setState(() {
        _lat = value.latitude;
        _long = value.longitude;
        _location = '$_lat,$_long';
        _loading = true;
      });
      print(_location);
      _futureEvent = _event();
    });
  }

  Future<List<Event>> _event() async {
    List list = await Api().fetch('events',
        queryParams: {'geolocation': _location, 'sortby': 'distance'});
    var event = list.map((item) => Event.fromJson(item)).toList();
    return event;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF608FB7),
        title: Text(
          'งาน/เทศกาล ในช่วงนี้',
          style: GoogleFonts.prompt(fontSize: 20.0),
        ),
      ),
      body: _loading == false
          ? Container(
              color: Colors.white,
              child: Center(
                child: SizedBox(
                  width: 30.0,
                  height: 30.0,
                  child: CircularProgressIndicator(color: Color(0xFF608FB7)),
                ),
              ),
            )
          : Container(
              child: FutureBuilder<List<Event>>(
                future: _futureEvent,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Center(
                      child:
                          CircularProgressIndicator(color: Color(0xFF608FB7)),
                    );
                  }

                  if (snapshot.hasData) {
                    var eventList = snapshot.data;
                    return ListView.builder(
                      padding: EdgeInsets.all(8.0),
                      itemCount: eventList!.length,
                      itemBuilder: (BuildContext context, int index) {
                        var eventItem = eventList[index];

                        return Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          margin: EdgeInsets.all(8.0),
                          elevation: 5.0,
                          shadowColor: Colors.black.withOpacity(0.2),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailEventPage(
                                          event_id: eventItem.event_id)));
                            },
                            child: Row(
                              children: <Widget>[
                                Image.network(
                                  eventItem.thumbnail_url,
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Container(
                                        width: 80.0,
                                        height: 80.0,
                                        child: Center(
                                          child: Text(
                                            ' ไม่มีรูป',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.prompt(
                                                fontSize: 15.0,
                                                color: Colors.red.shade200),
                                          ),
                                        ));
                                  },
                                  width: 95.0,
                                  height: 95.0,
                                  fit: BoxFit.cover,
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: 250.0,
                                              child: Text(
                                                eventItem.event_name,
                                                style: GoogleFonts.prompt(
                                                    fontSize: 18.0),
                                              ),
                                            ),
                                            Text(
                                              eventItem
                                                  .display_event_period_date,
                                              style: GoogleFonts.prompt(
                                                  fontSize: 15.0,
                                                  color: Colors.blueGrey),
                                            ),
                                            Container(
                                              width: 250.0,
                                              child: Text(
                                                eventItem.event_introduction,
                                                style: GoogleFonts.prompt(
                                                    fontSize: 15.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('ผิดพลาด: ${snapshot.error}'),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _futureEvent = _event();
                                  _location = '$_lat,$_long';
                                });
                              },
                              child: Text('ลองใหม่')),
                        ],
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
    );
  }
}
