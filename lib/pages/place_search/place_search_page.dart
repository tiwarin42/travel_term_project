import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_term_project/pages/home/home_page.dart';
import 'package:travel_term_project/pages/place_search/list_place_search.dart';

class PlaceSearchPage extends StatefulWidget {
  static const routeName = '/place_search_page';

  const PlaceSearchPage({Key? key}) : super(key: key);

  @override
  _PlaceSearchPageState createState() => _PlaceSearchPageState();
}

class _PlaceSearchPageState extends State<PlaceSearchPage> {
  var _province;
  var _Select;
  var _Type;
  final _controller = TextEditingController();
  var clear;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 370.0,
                    child: TextField(
                      controller: _controller,
                      style: GoogleFonts.prompt(
                        color: Colors.teal,
                        fontSize: 20.0,
                      ),
                      cursorColor: Color(0xFF6FB1B4),
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF3A727F), width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueGrey, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        focusColor: Colors.teal,
                        hintText: 'ป้อนจังหวัด เช่น นนทบุรี, เชียงใหม่, ภูเก็ต',
                        hintStyle: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'สถานที่ท่องเที่ยว',
                      style: GoogleFonts.prompt(fontSize: 15.0),
                    ),
                    leading: Radio(
                      value: 1,
                      groupValue: _Select,
                      onChanged: (value) {
                        setState(() {
                          _Select = value;
                        });
                      },
                      activeColor: Colors.teal,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'ที่พัก',
                      style: GoogleFonts.prompt(fontSize: 15.0),
                    ),
                    leading: Radio(
                      value: 2,
                      groupValue: _Select,
                      onChanged: (value) {
                        setState(() {
                          _Select = value;
                        });
                      },
                      activeColor: Colors.teal,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'ร้านอาหาร',
                      style: GoogleFonts.prompt(fontSize: 15.0),
                    ),
                    leading: Radio(
                      value: 3,
                      groupValue: _Select,
                      onChanged: (value) {
                        setState(() {
                          _Select = value;
                        });
                      },
                      activeColor: Colors.teal,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'ร้านค้า',
                      style: GoogleFonts.prompt(fontSize: 15.0),
                    ),
                    leading: Radio(
                      value: 4,
                      groupValue: _Select,
                      onChanged: (value) {
                        setState(() {
                          _Select = value;
                        });
                      },
                      activeColor: Colors.teal,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'อื่นๆ',
                      style: GoogleFonts.prompt(fontSize: 15.0),
                    ),
                    leading: Radio(
                      value: 5,
                      groupValue: _Select,
                      onChanged: (value) {
                        setState(() {
                          _Select = value;
                        });
                      },
                      activeColor: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 60.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, HomePage.routeName);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.arrow_back_outlined,
                              color: Colors.white,
                              size: 40.0,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              'ย้อนกลับ',
                              style: GoogleFonts.prompt(
                                color: Colors.white,
                                fontSize: 23.0,
                              ),
                            ),
                          ],
                        ),
                      )),
                  Container(
                      height: 60.0,
                      width: 180.0,
                      decoration: BoxDecoration(
                        color: Color(0xFF03878F),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _province = _controller.text;
                            if (_Select == 1) {
                              _Type = 'ATTRACTION';
                            } else if (_Select == 2) {
                              _Type = 'ACCOMMODATION';
                            } else if (_Select == 3) {
                              _Type = 'RESTAURANT';
                            } else if (_Select == 4) {
                              _Type = 'SHOP';
                            } else {
                              _Type = 'OTHER';
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListPlaceSearch(
                                        province: _province,
                                        type: _Type,
                                      )),
                            );
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 40.0,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              'ค้นหา',
                              style: GoogleFonts.prompt(
                                color: Colors.white,
                                fontSize: 23.0,
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
