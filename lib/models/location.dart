class Location {
  final String address;
  final String sub_district;
  final String district;
  final String province;

  Location({
    required this.address,
    required this.sub_district,
    required this.district,
    required this.province,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        address: json['address'],
        district: json['district'],
        sub_district: json['sub_district'],
        province: json['province']);
  }
}
