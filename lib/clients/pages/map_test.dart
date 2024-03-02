import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps with GetX'),
      ),
      body: Center(
        child: GetBuilder<MapController>(
          builder: (controller) {
            if (controller != null) {
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: controller.initialPosition,
                  zoom: 15.0,
                ),
                onMapCreated: controller.onMapCreated,
              );
            } else {
              // Return a placeholder widget or loading indicator
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

class MapController extends GetxController {
  final initialPosition = LatLng(37.7749, -122.4194);
  late GoogleMapController googleMapController;

  void onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }
}
