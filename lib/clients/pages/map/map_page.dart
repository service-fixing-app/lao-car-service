import 'dart:async';
import 'dart:math' show asin, cos, pi, sin, sqrt;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Location _locationController = Location();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  static const LatLng _firstLocation = LatLng(17.9667, 102.6000);
  static const LatLng _secondLocation = LatLng(17.9667, 102.6100);

  LatLng? _currentPosition = null;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  // Get the current location of the user
  Future<void> _getLocation() async {
    try {
      LocationData locationData = await _locationController.getLocation();
      setState(() {
        _currentPosition =
            LatLng(locationData.latitude!, locationData.longitude!);
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  // Calculate distance between two points using Haversine formula
  double _calculateDistance(LatLng start, LatLng end) {
    const double earthRadius = 6371000; // Radius of the earth in meters
    double lat1 = start.latitude;
    double lon1 = start.longitude;
    double lat2 = end.latitude;
    double lon2 = end.longitude;
    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    double c = 2 * asin(sqrt(a));
    double distance = earthRadius * c; // Distance in meters
    return distance;
  }

  double _toRadians(double degree) {
    return degree * (pi / 180);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _currentPosition == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : GoogleMap(
                  onMapCreated: (GoogleMapController controller) =>
                      _mapController.complete(controller),
                  initialCameraPosition: CameraPosition(
                    target: _currentPosition!,
                    zoom: 13,
                  ),
                  mapType: MapType.hybrid,
                  markers: {
                    Marker(
                      markerId: const MarkerId("_currentLocation"),
                      icon: BitmapDescriptor.defaultMarker,
                      position: _currentPosition!,
                      infoWindow: const InfoWindow(
                        title: "ທີ່ຢູ່ຂອງທ່ານ",
                      ),
                    ),
                    const Marker(
                      markerId: MarkerId("_destinationLocation"),
                      icon: BitmapDescriptor.defaultMarker,
                      position: _secondLocation,
                    ),
                  },
                  polylines: {
                    Polyline(
                      polylineId: const PolylineId("route"),
                      color: Colors.blue,
                      points: [
                        _currentPosition!,
                        _secondLocation,
                      ],
                    ),
                  },
                ),
          Positioned(
            left: 30,
            top: 50,
            child: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_rounded,
                size: 35,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //logic get started
        },
        child: const Icon(Icons.directions),
      ),
    );
  }
}
