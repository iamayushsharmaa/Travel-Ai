import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TripMap extends StatefulWidget {
  final double currentLat;
  final double currentLng;
  final double destinationLat;
  final double destinationLng;
  final String destinationName;
  final double height;

  const TripMap({
    super.key,
    required this.currentLat,
    required this.currentLng,
    required this.destinationLat,
    required this.destinationLng,
    required this.destinationName,
    this.height = 200,
  });

  @override
  State<TripMap> createState() => _TripMapState();
}

class _TripMapState extends State<TripMap> {
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    final currentPosition = LatLng(widget.currentLat, widget.currentLng);
    final destinationPosition = LatLng(
      widget.destinationLat,
      widget.destinationLng,
    );

    final markers = <Marker>{
      Marker(
        markerId: const MarkerId('current'),
        position: currentPosition,
        infoWindow: const InfoWindow(title: 'Current Location'),
      ),
      Marker(
        markerId: const MarkerId('destination'),
        position: destinationPosition,
        infoWindow: InfoWindow(title: widget.destinationName),
      ),
    };

    final polylines = <Polyline>{
      Polyline(
        polylineId: const PolylineId('route'),
        points: [currentPosition, destinationPosition],
        color: Colors.blue,
        width: 4,
      ),
    };

    return Container(
      height: widget.height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
              (widget.currentLat + widget.destinationLat) / 2,
              (widget.currentLng + widget.destinationLng) / 2,
            ),
            zoom: 10,
          ),
          markers: markers,
          polylines: polylines,
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
          onMapCreated: (controller) {
            mapController = controller;
            _fitMapToMarkers(currentPosition, destinationPosition);
          },
        ),
      ),
    );
  }

  void _fitMapToMarkers(LatLng current, LatLng destination) {
    if (mapController == null) return;

    // Same location case
    if (current.latitude == destination.latitude &&
        current.longitude == destination.longitude) {
      mapController!.animateCamera(CameraUpdate.newLatLngZoom(current, 14));
      return;
    }

    final bounds = LatLngBounds(
      southwest: LatLng(
        min(current.latitude, destination.latitude),
        min(current.longitude, destination.longitude),
      ),
      northeast: LatLng(
        max(current.latitude, destination.latitude),
        max(current.longitude, destination.longitude),
      ),
    );

    Future.microtask(() {
      mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    });
  }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }
}
