import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_term_project/models/detail.dart';
import 'package:travel_term_project/models/location.dart';
import 'package:travel_term_project/services/api.dart';

class DetailPage extends StatefulWidget {
  final path;
  final place_id;

  const DetailPage({Key? key, required this.path, required this.place_id})
      : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var _name, _information, _detail, _pic;
  var _address, _sub_district, _district, _province, _postcode;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _placeDetail();
  }

  void _placeDetail() async {
    Map<String, dynamic> map =
        await Api().fetch('${widget.path}/${widget.place_id}');

    setState(() {
      _name = map["place_name"];
      _information = map["place_information"]["introduction"];
      _detail = map["place_information"]["detail"];
      _address = map["location"]["address"];
      _sub_district = map["location"]["sub_district"];
      _district = map["location"]["district"];
      _province = map["location"]["province"];
      _postcode = map["location"]["postcode"];
      _pic = map["thumbnail_url"];
      _loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF45AAB4),
          title: Text(
            'รายละเอียดสถานที่',
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
                    child: CircularProgressIndicator(color: Color(0xFF45AAB4)),
                  ),
                ),
              )
            : ListView(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            _pic,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace? stackTrace) {
                              return Container(
                                  width: 160.0,
                                  height: 160.0,
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
                            width: 200,
                            height: 200,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          child: Container(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ชื่อ',
                                  style: GoogleFonts.prompt(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '$_name',
                                  style: GoogleFonts.prompt(
                                      fontSize: 18.0,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  'รายละเอียด',
                                  style: GoogleFonts.prompt(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  _detail == null ? _information : _detail,
                                  style: GoogleFonts.prompt(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade600),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  'ที่อยู่',
                                  style: GoogleFonts.prompt(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '$_address $_sub_district $_district $_province $_postcode',
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
