// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class BagTimelineWidget extends StatefulWidget {
//   final String bagId;
//   const BagTimelineWidget({super.key, required this.bagId});

//   @override
//   State<BagTimelineWidget> createState() => _BagTimelineWidgetState();
// }

// class _BagTimelineWidgetState extends State<BagTimelineWidget> {
//   List<Map<String, dynamic>> _timeline = [];
//   Timer? _timer;

//   Future<void> _fetchTimeline() async {
//     try {
//       final res = await http.get(
//         Uri.parse('http://localhost:3000/bags/${widget.bagId}/timeline'),
//       );
//       if (res.statusCode == 200) {
//         final data = jsonDecode(res.body) as List;
//         setState(() {
//           _timeline = data.cast<Map<String, dynamic>>();
//         });
//       }
//     } catch (e) {
//       debugPrint("Erro ao buscar timeline: $e");
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     _fetchTimeline();
//     _timer = Timer.periodic(const Duration(seconds: 5), (_) => _fetchTimeline());
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _timeline.isEmpty
//         ? const Center(child: Text("Nenhuma atualização ainda..."))
//         : ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: _timeline.length,
//             itemBuilder: (context, index) {
//               final item = _timeline[index];
//               return Card(
//                 elevation: 2,
//                 margin: const EdgeInsets.only(bottom: 10),
//                 child: ListTile(
//                   leading: const Icon(Icons.flight_takeoff, color: Colors.blue),
//                   title: Text(item["message"]),
//                   subtitle: Text(item["time"].toString().substring(0, 19)),
//                 ),
//               );
//             },
//           );
//   }
// }
