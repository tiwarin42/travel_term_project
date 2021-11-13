class Place {
  final String place_id;
  final String place_name;
  final String thumbnail_url;
  final String destination;
  final dynamic location;

  Place({
    required this.place_name,
    required this.thumbnail_url,
    required this.destination,
    required this.place_id,
    required this.location,
  });

  factory Place.fromJson(Map<String, dynamic> json){
    return Place(place_name: json['place_name'],
        thumbnail_url: json['thumbnail_url'],
        destination: json['destination'],
        place_id: json['place_id'],
        location: json['location']);
  }
}
