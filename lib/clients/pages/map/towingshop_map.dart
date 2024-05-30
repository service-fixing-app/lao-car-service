import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:service_fixing/clients/controllers/reviews/getReviews_controller.dart';
import 'package:service_fixing/clients/controllers/reviews/reviews_controller.dart';
import 'package:service_fixing/clients/controllers/shop/getTowingshopController.dart';
import 'package:service_fixing/clients/controllers/shop/openShop_controller.dart';
import 'package:service_fixing/clients/pages/map/review_ratestar.dart';
import 'package:service_fixing/clients/pages/map/slidebutton.dart';
import 'package:intl/intl.dart';

class TowingshopMap extends StatefulWidget {
  final double? customerlatitude;
  final double? customerclongitude;
  TowingshopMap({
    Key? key,
    this.customerlatitude,
    this.customerclongitude,
  }) : super(key: key);

  @override
  State<TowingshopMap> createState() => _TowingshopMapState();
}

class _TowingshopMapState extends State<TowingshopMap>
    with SingleTickerProviderStateMixin {
  final OpenshopController openshopController = Get.find();
  final GetTowingshopController getTowingLocationController =
      Get.put(GetTowingshopController());
  final ReviewsController reviewsController = Get.put(ReviewsController());
  Location locationController = Location();

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  // Example location
  // static const LatLng _secondLocation = LatLng(
  //   18.00458164001826,
  //   102.6370970159769,
  // );

  LatLng? _currentPosition;
  double? clatitude;
  double? clongitude;

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
        clatitude = locationData.latitude!;
        clongitude = locationData.longitude!;
        // print("clatitude $clatitude");
        // print("clongitude $clongitude");
        // print(' current location : $_currentPosition');
      });
    } catch (e) {
      // print("Error getting location: $e");
    }
  }

  late TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getLocation();
    _tabController = TabController(length: 2, vsync: this);
  }

  Widget _buildStarRating(List<dynamic> ratingStarList) {
    if (ratingStarList.isEmpty) {
      return RatingBar.builder(
        initialRating: 0,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        itemSize: 16.0,
        onRatingUpdate: (rating) {
          print(rating);
        },
      );
    }

    double totalScore = 0;
    for (var rating in ratingStarList) {
      totalScore += rating['rating'];
    }
    double averageScore = totalScore / ratingStarList.length;
    print('avg $averageScore');

    return RatingBar.builder(
      initialRating: averageScore,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemSize: 16.0,
      onRatingUpdate: (rating) {
        print(rating);
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
                      draggable: true,
                      infoWindow: const InfoWindow(
                        title: "ທີ່ຢູ່ຂອງທ່ານ",
                      ),
                      onDragEnd: (LatLng newPosition) {
                        setState(() {
                          _currentPosition = newPosition;
                          clatitude = newPosition.latitude;
                          clongitude = newPosition.longitude;
                        });
                      },
                    ),
                    // loop maker in here

                    if (getTowingLocationController.shopLocations.isNotEmpty)
                      for (var shopLocation
                          in getTowingLocationController.shopLocations)
                        if (shopLocation['permission'] == "true")
                          Marker(
                            markerId: MarkerId(
                                "${shopLocation['latitude']}-${shopLocation['longitude']}"),
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueAzure),
                            infoWindow: InfoWindow(
                              title: shopLocation['shopName'],
                            ),
                            position: LatLng(
                              double.parse(shopLocation['latitude'].toString()),
                              double.parse(
                                  shopLocation['longitude'].toString()),
                            ),
                            onTap: () {
                              print("shoplocation: $shopLocation");
                              _showBottomSheet(
                                context,
                                "${shopLocation['shopName']}",
                                "ເຈົ້າຂອງຮ້ານ: ${shopLocation['managerName']}",
                                "${shopLocation['phoneNumber']}",
                                'ນິຍົມ : ',
                                _buildStarRating(
                                    reviewsController.ratingStarList),
                                'ຮັບບໍລິການສ້ອມແປງລົດຈັກ (8ໂມງເຊົ້າ - 5ໂມງແລງ)',
                                shopLocation['id'],
                                shopLocation['Status'],
                              );
                            },
                          ),
                    if (widget.customerlatitude != null &&
                        widget.customerclongitude != null &&
                        widget.customerlatitude! != 0.0 &&
                        widget.customerclongitude! != 0.0)
                      // Add the marker for customer location
                      Marker(
                        markerId: const MarkerId('customer location'),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueGreen,
                        ),
                        infoWindow: const InfoWindow(
                          title: 'ຕຳແໜ່ງລູກຄ້າ',
                        ),
                        position: LatLng(
                          widget.customerlatitude!,
                          widget.customerclongitude!,
                        ),
                      )

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

  // Function to show bottom sheet
  void _showBottomSheet(
      BuildContext context,
      String markerName,
      String ownerName,
      String tel,
      String score,
      Widget ratingStar,
      String typeOfService,
      String shopId,
      String statusOpenShop) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      builder: (BuildContext context) {
        final ReviewsController getreviewsController =
            Get.find<ReviewsController>();
        final GetReviewController getCustomerReviewsController =
            Get.put(GetReviewController());
        reviewsController.getRatingStar(shopId);
        getCustomerReviewsController.getReviews(shopId);
        // Function to format the date string
        String formatDateString(String dateString) {
          DateTime dateTime = DateTime.parse(dateString);
          return DateFormat('dd/MM/yyyy').format(dateTime);
        }

        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.5,
          maxChildSize: 1.0,
          expand: false,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                controller: scrollController,
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 50.0,
                              height: 4.0,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ຮ້ານ $markerName ',
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              statusOpenShop,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: statusOpenShop == 'ເປີດ'
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                          // Obx(() {
                          //   final isOpen = openshopController.isOpen.value;
                          //   return Switch(
                          //     value: isOpen,
                          //     onChanged: (value) {
                          //       openshopController.isOpen.value = value;
                          //     },
                          //     activeColor: primaryColor,
                          //   );
                          // }),
                        ],
                      ),
                      // Text(shopId),
                      Text(
                        ownerName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'phetsarath_ot',
                        ),
                      ),
                      Text(
                        'ເບີຕິດຕໍ່: $tel',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'phetsarath_ot',
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            score,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'phetsarath_ot',
                            ),
                          ),
                          ratingStar,
                        ],
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
                      const Divider(height: 4),
                      const SizedBox(height: 10),
                      // all buttons
                      SlideButtons(
                        clatitude: clatitude,
                        clongitude: clongitude,
                        markerName: markerName,
                        score: score,
                        tel: tel,
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              width: 300.0,
                              height: 240.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset(
                                  'assets/images/exampleImg1.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 2),
                            Column(
                              children: [
                                Container(
                                  width: 200.0,
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset(
                                      'assets/images/exampleImg2.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Container(
                                  width: 200.0,
                                  height: 120.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset(
                                      'assets/images/exampleImg3.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      TabBar(
                        controller: _tabController,
                        labelColor: Colors.black45,
                        labelStyle: const TextStyle(fontSize: 18),
                        tabs: const <Widget>[
                          Tab(
                            text: 'Overview',
                          ),
                          Tab(text: 'Review'),
                        ],
                      ),
                      SingleChildScrollView(
                        child: SizedBox(
                          height: 700, // Set a fixed height or adjust as needed
                          child: TabBarView(
                            controller: _tabController,
                            children: <Widget>[
                              const Card(
                                margin: EdgeInsets.all(0.0),
                                child: Column(
                                  children: [],
                                ),
                              ),
                              Obx(() {
                                final ratingStarList =
                                    getreviewsController.ratingStarList;
                                final ratingAverages =
                                    calculateRatingAverages(ratingStarList);
                                final averageScore =
                                    ratingAverages['averageScore'] ?? 0.0;

                                return Card(
                                  margin: const EdgeInsets.all(0.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 20),
                                      const Text('ການປະເມີນ'),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              averageScore.toStringAsFixed(1),
                                              style: const TextStyle(
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 7,
                                            child: Column(
                                              children: [
                                                TRatingProccessing(
                                                  numberRate: '5',
                                                  value: ratingAverages['5'] ??
                                                      0.0,
                                                ),
                                                TRatingProccessing(
                                                  numberRate: '4',
                                                  value: ratingAverages['4'] ??
                                                      0.0,
                                                ),
                                                TRatingProccessing(
                                                  numberRate: '3',
                                                  value: ratingAverages['3'] ??
                                                      0.0,
                                                ),
                                                TRatingProccessing(
                                                  numberRate: '2',
                                                  value: ratingAverages['2'] ??
                                                      0.0,
                                                ),
                                                TRatingProccessing(
                                                  numberRate: '1',
                                                  value: ratingAverages['1'] ??
                                                      0.0,
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      RatingBar.builder(
                                        initialRating: averageScore,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 0.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemSize: 16.0,
                                        onRatingUpdate: (rating) {
                                          // print(rating);
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 45.0,
                                            width: 100.0,
                                            child: OutlinedButton(
                                              onPressed: () {
                                                Get.to(() => ReviewRatingStar(
                                                    shopId: shopId));
                                              },
                                              style: OutlinedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                ),
                                                padding:
                                                    const EdgeInsets.all(0),
                                              ),
                                              child: const Center(
                                                child: Text('ຂຽນຄຳຕິຊົມ'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      const Divider(height: 2),
                                      const SizedBox(height: 20),
                                      buildAllComments(
                                        getCustomerReviewsController:
                                            getCustomerReviewsController,
                                        formatDateString: formatDateString,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class buildAllComments extends StatelessWidget {
  const buildAllComments({
    super.key,
    required this.getCustomerReviewsController,
    required this.formatDateString,
  });

  final GetReviewController getCustomerReviewsController;
  final String Function(String) formatDateString;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () {
          if (getCustomerReviewsController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (getCustomerReviewsController.customerReviews.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/empty-folder.png',
                    fit: BoxFit.cover,
                  ),
                  const Text(
                    'ຍັງບໍ່ມີຂໍ້ຄວາມຮ້ອງຂໍ',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: getCustomerReviewsController.customerReviews.length,
              itemBuilder: (BuildContext context, int index) {
                final review =
                    getCustomerReviewsController.customerReviews[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                review.profileImage,
                              ),
                              radius: 20,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  review.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  formatDateString(review.createdAt.toString()),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        RatingBarIndicator(
                          rating: review.rate,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 16.0,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          review.comment,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

Map<String, double> calculateRatingAverages(List<dynamic> ratingStarList) {
  Map<String, double> averages = {
    '5': 0.0,
    '4': 0.0,
    '3': 0.0,
    '2': 0.0,
    '1': 0.0,
    'averageScore': 0.0,
  };

  if (ratingStarList.isEmpty) {
    return averages;
  }

  double totalScore = 0.0;

  for (var rating in ratingStarList) {
    int star = rating['rating'];
    totalScore += star;
    averages[star.toString()] = (averages[star.toString()] ?? 0.0) + 1;
  }

  int totalRatings = ratingStarList.length;
  averages['averageScore'] = totalScore / totalRatings;

  averages['5'] = averages['5']! / totalRatings;
  averages['4'] = averages['4']! / totalRatings;
  averages['3'] = averages['3']! / totalRatings;
  averages['2'] = averages['2']! / totalRatings;
  averages['1'] = averages['1']! / totalRatings;

  return averages;
}

class TRatingProccessing extends StatelessWidget {
  final String numberRate;
  final double value;

  const TRatingProccessing(
      {super.key, required this.numberRate, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(numberRate),
        ),
        Expanded(
          flex: 11,
          child: SizedBox(
            child: LinearProgressIndicator(
              value: value,
              minHeight: 10,
              backgroundColor: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(7),
              valueColor: const AlwaysStoppedAnimation(Colors.amber),
            ),
          ),
        )
      ],
    );
  }
}