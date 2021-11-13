class Detail {
  final String place_name;
  final String thumbnail_url;
  final String destination;
  final dynamic place_information;
  final dynamic location;
  final dynamic phone;

  Detail({
    required this.place_name,
    required this.thumbnail_url,
    required this.destination,
    required this.place_information,
    required this.location,
    required this.phone,
  });

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
        place_name: json['place_name'],
        thumbnail_url: json['thumbnail_url'],
        destination: json['destination'],
        place_information: json['place_information'],
        location: json['location'],
        phone: json['phone']);
  }

}
