import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

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

  List<Marker> _marker = [
    Marker(
        markerId: MarkerId("1"),
        position: LatLng(
          17.9667,
          102.6000,
        ),
        draggable: true,
        onDragEnd: (e) {
          print(e.toJson());
        })
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPosition == null
          ? Center(
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
                  markerId: MarkerId("_currentLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _currentPosition!,
                  infoWindow: const InfoWindow(
                    title: "ທີ່ຢູ່ຂອງເຈົ້າ",
                  ),
                ),
                Marker(
                  markerId: MarkerId("_destinationLocation"),
                  icon: BitmapDescriptor.defaultMarker,
                  position: _secondLocation,
                ),
              },
            ),
    );
  }
}
