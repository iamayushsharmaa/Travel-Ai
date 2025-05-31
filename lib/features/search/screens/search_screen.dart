import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:triptide/features/home/screens/widgets/trip_view.dart';

import '../providers/search_provider.dart'; // Optional if using GoRouter

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  String _query = "";

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () {
      setState(() => _query = value.trim().toLowerCase());
      ref.invalidate(searchTripProvider); // reset cache
    });
  }

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(searchTripProvider(_query));

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade100,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: TextField(
            controller: _controller,
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Search trips',
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
      ),
      body: Column(
        children: [
          Expanded(
            child: result.when(
              data:
                  (items) => ListView.builder(
                    itemCount: items.length,
                    itemBuilder:
                        (context, index) =>
                            TripView(onTripClicked: (travelId) {}),
                  ),
              loading: () => Center(child: CircularProgressIndicator()),
              error: (e, _) => Text("Error: $e"),
            ),
          ),
        ],
      ),
    );
  }
}
