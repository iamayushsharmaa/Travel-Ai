import 'package:flutter/material.dart';

class TripPage extends StatelessWidget {
  final String travelId;

  const TripPage({super.key, required this.travelId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip to ${travelId}'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(children: [Text('Trip to ${travelId}')]),
    );
  }
}
