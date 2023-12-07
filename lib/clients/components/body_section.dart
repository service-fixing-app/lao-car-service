import 'package:flutter/material.dart';
import '../../constants.dart';

class BodySection extends StatelessWidget {
  const BodySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: bgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shop for',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Show all',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: primaryColor,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 365,
                              decoration: BoxDecoration(
                                color: const Color(0xFFD6EAF8),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.network(
                                        'https://p7.hiclipart.com/preview/332/742/376/car-automobile-repair-shop-motor-vehicle-service-hand-painted-garage.jpg',
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.contain,
                                      ),
                                      const SizedBox(
                                        width: 20.0,
                                      ),
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Auto Repar car',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          Text(
                                            'best shop reapair',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    '1st',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 365,
                              decoration: BoxDecoration(
                                color: const Color(0xFFD6EAF8),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.network(
                                        'https://p7.hiclipart.com/preview/332/742/376/car-automobile-repair-shop-motor-vehicle-service-hand-painted-garage.jpg',
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.contain,
                                      ),
                                      const SizedBox(
                                        width: 20.0,
                                      ),
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Auto Repar car',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          Text(
                                            'best shop reapair',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    '1st',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 365,
                              decoration: BoxDecoration(
                                color: const Color(0xFFD6EAF8),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.network(
                                        'https://p7.hiclipart.com/preview/332/742/376/car-automobile-repair-shop-motor-vehicle-service-hand-painted-garage.jpg',
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.contain,
                                      ),
                                      const SizedBox(
                                        width: 20.0,
                                      ),
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Auto Repar car',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          Text(
                                            'best shop reapair',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    '1st',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 365,
                              decoration: BoxDecoration(
                                color: const Color(0xFFD6EAF8),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.network(
                                        'https://p7.hiclipart.com/preview/332/742/376/car-automobile-repair-shop-motor-vehicle-service-hand-painted-garage.jpg',
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.contain,
                                      ),
                                      const SizedBox(
                                        width: 20.0,
                                      ),
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Auto Repar car',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          Text(
                                            'best shop reapair',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    '1st',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
