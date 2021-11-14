import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_term_project/services/api.dart';

class DetailEventPage extends StatefulWidget {
  final event_id;

  const DetailEventPage({Key? key, required this.event_id}) : super(key: key);

  @override
  _DetailEventPageState createState() => _DetailEventPageState();
}

class _DetailEventPageState extends State<DetailEventPage> {
  var _name, _information, _detail, _period_date;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _eventDetail();
  }

  void _eventDetail() async {
    Map<String, dynamic> map = await Api().fetch('events/${widget.event_id}');

    setState(() {
      _name = map["event_name"];
      _information = map["event_information"]["event_introduction"];
      _detail = map["event_information"]["event_html_detail"];
      _period_date = map["display_event_period_date"];
      _loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF0C4876),
          title: Text(
            'รายละเอียดงาน/เทศกาล',
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
                    child: CircularProgressIndicator(color: Color(0xFF0C4876)),
                  ),
                ),
              )
            : ListView(
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'ชื่อ',
                                  style: GoogleFonts.prompt(fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '$_name',
                                  style: GoogleFonts.prompt(fontSize: 18.0,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 20.0,),
                                Text(
                                  'ระยะเวลา',
                                  style: GoogleFonts.prompt(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '$_period_date',
                                  style: GoogleFonts.prompt(fontSize: 18.0,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 20.0,),
                                Text(
                                  'รายละเอียด',
                                  style: GoogleFonts.prompt(fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '${_detail.replaceAll(RegExp(r'[<p>\</p>\&nbs;]'), '')}',
                                  style: GoogleFonts.prompt(fontSize: 17.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade600),
                                ),
                                SizedBox(height: 20.0),
                                Text(
                                  'สถานที่',
                                  style: GoogleFonts.prompt(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  _information,
                                  style: GoogleFonts.prompt(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ));
  }
}
