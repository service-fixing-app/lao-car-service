import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:service_fixing/clients/pages/map/consts.dart';
import 'package:service_fixing/clients/pages/services/service_repair.dart';

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
  static const LatLng _secondLocation =
      LatLng(17.99795372766358, 102.64246981590986);

  LatLng? _currentPosition = null;

  //Get the current location of the user
  Future<void> _getLocation() async {
    try {
      bool serviceEnabled = await _locationController.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _locationController.requestService();
        if (!serviceEnabled) {
          // Location services are still disabled, handle this case
          return;
        }
      }

      PermissionStatus permissionStatus =
          await _locationController.hasPermission();
      if (permissionStatus == PermissionStatus.denied) {
        permissionStatus = await _locationController.requestPermission();
        if (permissionStatus != PermissionStatus.granted) {
          // Location permission is denied, handle this case
          return;
        }
      }

      LocationData locationData = await _locationController.getLocation();
      setState(() {
        _currentPosition =
            LatLng(locationData.latitude!, locationData.longitude!);
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _getLocation();
    // getPolylines();
  }
  // get polylines

  List<LatLng> polylineCoordinates = [];
  void getPolylines() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult polylineResult =
        await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey,
      PointLatLng(_firstLocation.latitude, _firstLocation.longitude),
      PointLatLng(
        _secondLocation.latitude,
        _secondLocation.longitude,
      ),
    );
    if (polylineResult.points.isNotEmpty) {
      polylineResult.points.forEach(
        (PointLatLng points) => polylineCoordinates.add(
          LatLng(points.latitude, points.longitude),
        ),
      );
    }
    setState(() {});
  }

  // Function to show bottom sheet
  void _showBottomSheet(BuildContext context, String markerName, String score,
      String typeOfService) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50.0,
                    height: 4.0,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                markerName,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                score,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'phetsarath_ot',
                ),
              ),
              Text(
                typeOfService,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'phetsarath_ot',
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 45.0,
                      // width: 180.0,
                      child: ElevatedButton(
                        onPressed: () {
                          // any logic
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          elevation: 3.0,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.directions,
                            ),
                            Text(
                              'Direction',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 45.0,
                      // width: 180.0,
                      child: ElevatedButton(
                        onPressed: () {
                          // any logic
                          Get.to(const ServiceRepair());
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            side: const BorderSide(
                                color: Colors.grey,
                                width: 2.0), // Add button border
                          ),
                          elevation: 3.0,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.help,
                              color: Colors.grey,
                            ),
                            Text(
                              'ຮ້ອງບໍລິການ',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: 100.0,
                height: 200.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black45),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    'assets/images/shopimage.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
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
                    Marker(
                      markerId: const MarkerId("_destinationLocation"),
                      draggable: true,
                      onDragEnd: (LatLng newPosition) {
                        // Print the new position
                        print('New position: $newPosition');
                      },
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueAzure),
                      position: _secondLocation,
                      // infoWindow: InfoWindow(
                      //   title: 'ຮ້ານສ້ອມແປງລົດຈັກ',
                      //   snippet:
                      //       'Latitude: ${_secondLocation.latitude}, Longitude: ${_secondLocation.longitude}',
                      // ),
                      onTap: () {
                        _showBottomSheet(
                          context,
                          'ຮ້ານສ້ອມແປງລົດຈັກ',
                          'ຄະແນນ : 100',
                          'ຮັບບໍລິການສ້ອມແປງລົດຈັກ (8ໂມງເຊົ້າ - 5ໂມງແລງ)',
                        ); // Pass marker name or other relevant data
                      },
                    ),
                  },
                  polylines: {
                    Polyline(
                      polylineId: const PolylineId("route"),
                      color: Colors.blue,
                      // points: [
                      //   _currentPosition!,
                      //   _secondLocation,
                      // ],
                      points: polylineCoordinates,
                      width: 6,
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
