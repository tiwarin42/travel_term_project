class Event {
  final String event_id;
  final String event_name;
  final String display_event_period_date;
  final String event_introduction;
  final String thumbnail_url;
  final String location;

  Event({
    required this.event_id,
    required this.event_name,
    required this.display_event_period_date,
    required this.event_introduction,
    required this.thumbnail_url,
    required this.location,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      event_id: json['event_id'],
      event_name: json['event_name'],
      display_event_period_date: json['display_event_period_date'],
      event_introduction: json['event_introduction'],
      thumbnail_url: json['thumbnail_url'],
      location: json['location'],
    );
  }
}
