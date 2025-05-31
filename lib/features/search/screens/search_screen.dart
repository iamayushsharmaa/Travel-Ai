import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Optional if using GoRouter

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  final List<String> allTrips = [
    'London Trip',
    'Paris Getaway',
    'New York Adventure',
    'Tokyo Tour',
    'Bali Beach',
    'Dubai Desert',
  ];
  List<String> filteredTrips = [];

  @override
  void initState() {
    super.initState();
    filteredTrips = allTrips; // Initially show all trips
  }

  void _searchTrips(String query) {
    setState(() {
      filteredTrips = allTrips
          .where((trip) => trip.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(), // Or Navigator.pop(context)
        ),
        title: TextField(
          controller: _controller,
          onChanged: _searchTrips,
          decoration: InputDecoration(
            hintText: 'Search trips...',
            filled: true,
            fillColor: Colors.white,
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: filteredTrips.length,
        itemBuilder: (context, index) {
          final trip = filteredTrips[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              title: Text(trip),
              onTap: () {
                // Navigate to selected trip
              },
            ),
          );
        },
      ),
    );
  }
}
