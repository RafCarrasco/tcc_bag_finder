class BagTimelineEvent {
  final DateTime time;
  final String message;
  final String epc;

  BagTimelineEvent({
    required this.time,
    required this.message,
    required this.epc,
  });

  factory BagTimelineEvent.fromJson(Map<String, dynamic> json) {
    return BagTimelineEvent(
      time: DateTime.parse(json['time']),
      message: json['message'],
      epc: json['epc'],
    );
  }
}
