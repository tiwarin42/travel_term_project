import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_term_project/models/place.dart';
import 'package:travel_term_project/pages/place_search/detail_page.dart';
import 'package:travel_term_project/services/api.dart';

class ListPlaceSearch extends StatefulWidget {
  final province;
  final type;

  const ListPlaceSearch({Key? key, required this.province, required this.type})
      : super(key: key);

  @override
  _ListPlaceSearchState createState() => _ListPlaceSearchState();
}

class _ListPlaceSearchState extends State<ListPlaceSearch> {
  late Future<List<Place>> _futurePlace;
  var _category;

  @override
  void initState() {
    super.initState();
    _futurePlace = _place();
  }

  Future<List<Place>> _place() async {
    List list = await Api().fetch('places/search', queryParams: {
      'provincename': widget.province,
      'categorycodes': widget.type
    });
    var place = list.map((item) => Place.fromJson(item)).toList();
    return place;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF64A2AD),
        title: Text(
          'สถานที่',
          style: GoogleFonts.prompt(fontSize: 20.0),
        ),
      ),
      body: Container(
        child: FutureBuilder<List<Place>>(
          future: _futurePlace,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: CircularProgressIndicator(color: Color(0xFF64A2AD)),
              );
            }
            if (snapshot.hasData) {
              var placeList = snapshot.data;
              return ListView.builder(
                padding: EdgeInsets.all(8.0),
                itemCount: placeList!.length,
                itemBuilder: (BuildContext context, int index) {
                  var placeItem = placeList[index];

                  return Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    margin: EdgeInsets.all(8.0),
                    elevation: 5.0,
                    shadowColor: Colors.black.withOpacity(0.2),
                    child: InkWell(
                      onTap: () {
                        if (widget.type == 'ATTRACTION') {
                          _category = 'attraction';
                        } else if (widget.type == 'ACCOMMODATION') {
                          _category = 'accommodation';
                        } else if (widget.type == 'RESTAURANT') {
                          _category = 'restaurant';
                        } else if (widget.type == 'SHOP') {
                          _category = 'shop';
                        } else {
                          _category = 'other';
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailPage(
                                      path: _category,
                                      place_id: placeItem.place_id,
                                    )));
                        },
                      child: Row(
                        children: <Widget>[
                          Image.network(
                            placeItem.thumbnail_url,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
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
                                          placeItem.place_name,
                                          style: GoogleFonts.prompt(
                                              fontSize: 18.0),
                                        ),
                                      ),
                                      Text(
                                        placeItem.destination,
                                        style:
                                            GoogleFonts.prompt(fontSize: 15.0),
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
                            _futurePlace = _place();
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
