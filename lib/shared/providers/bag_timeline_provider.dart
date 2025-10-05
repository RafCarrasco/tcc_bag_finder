import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../events/bag_timeline_event.dart';

class BagTimelineProvider extends ChangeNotifier {
  List<BagTimelineEvent> events = [];
  bool loading = false;

  Future<void> fetchTimeline(String bagId) async {
    loading = true;
    notifyListeners();

    final res = await http.get(Uri.parse("http://localhost:3000/bags/$bagId/timeline"));
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body) as List;
      events = data.map((e) => BagTimelineEvent.fromJson(e)).toList();
    }

    loading = false;
    notifyListeners();
  }
}
