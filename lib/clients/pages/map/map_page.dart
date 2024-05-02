import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:service_fixing/clients/controllers/shop/getShopLocation_controller.dart';
import 'package:service_fixing/clients/controllers/shop/openShop_controller.dart';
import 'package:service_fixing/clients/pages/customer/services/service_repair.dart';
import 'package:service_fixing/constants.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final OpenshopController openshopController = Get.find();
  final GetShopLocationController getShopLocationController = Get.put(
    GetShopLocationController(),
  );
  Location locationController = Location();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  // Example location
  // static const LatLng _secondLocation = LatLng(
  //   18.00458164001826,
  //   102.6370970159769,
  // );

  LatLng? _currentPosition;

  //Get the current location of the user
  Future<void> _getLocation() async {
    try {
      bool serviceEnabled = await locationController.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await locationController.requestService();
        if (!serviceEnabled) {
          // Location services are still disabled, handle this case
          return;
        }
      }

      PermissionStatus permissionStatus =
          await locationController.hasPermission();
      if (permissionStatus == PermissionStatus.denied) {
        permissionStatus = await locationController.requestPermission();
        if (permissionStatus != PermissionStatus.granted) {
          // Location permission is denied, handle this case
          return;
        }
      }

      LocationData locationData = await locationController.getLocation();
      setState(() {
        _currentPosition =
            LatLng(locationData.latitude!, locationData.longitude!);
      });
    } catch (e) {
      // print("Error getting location: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _getLocation();
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    markerName,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Obx(() {
                    final isOpen = openshopController.isOpen.value;
                    return Switch(
                      value: isOpen,
                      onChanged: (value) {
                        openshopController.isOpen.value = value;
                      },
                      activeColor: primaryColor,
                    );
                  }),
                ],
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
                    zoom: 14,
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
                    // loop maker in here
                    for (var shopLocation
                        in getShopLocationController.shopLocations)
                      Marker(
                        markerId: MarkerId(
                          "${shopLocation.latitude}-${shopLocation.longitude}",
                        ),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueAzure),
                        position: LatLng(
                          shopLocation.latitude,
                          shopLocation.longitude,
                        ),
                        onTap: () {
                          // Handle marker tap event
                          _showBottomSheet(
                            context,
                            'ຮ້ານສ້ອມແປງລົດຈັກ',
                            'ຄະແນນ : 100',
                            'ຮັບບໍລິການສ້ອມແປງລົດຈັກ (8ໂມງເຊົ້າ - 5ໂມງແລງ)',
                          );
                        },
                      ),
                    // Example location
                    // Marker(
                    //   markerId: const MarkerId("_destinationLocation"),
                    //   draggable: true,
                    //   onDragEnd: (LatLng newPosition) {
                    //   },
                    //   icon: BitmapDescriptor.defaultMarkerWithHue(
                    //       BitmapDescriptor.hueAzure),
                    //   position: _secondLocation,
                    //   onTap: () {
                    //     _showBottomSheet(
                    //       context,
                    //       'ຮ້ານສ້ອມແປງລົດຈັກ',
                    //       'ຄະແນນ : 100',
                    //       'ຮັບບໍລິການສ້ອມແປງລົດຈັກ (8ໂມງເຊົ້າ - 5ໂມງແລງ)',
                    //     ); // Pass marker name or other relevant data
                    //   },
                    // ),
                  },
                  // polylines: {
                  //   Polyline(
                  //     polylineId: const PolylineId("route"),
                  //     color: Colors.blue,
                  //     // points: [
                  //     //   _currentPosition!,
                  //     //   _secondLocation,
                  //     // ],
                  //     points: polylineCoordinates,
                  //     width: 6,
                  //   ),
                  // },
                ),
          Positioned(
            left: 30,
            top: 50,
            child: Container(
              height: 45,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      // Add your search functionality here
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
