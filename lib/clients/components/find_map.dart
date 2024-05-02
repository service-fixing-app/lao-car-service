import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindMap extends StatefulWidget {
  const FindMap({Key? key}) : super(key: key);

  @override
  State<FindMap> createState() => _FindMapState();
}

class _FindMapState extends State<FindMap> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: Container(
        height: 60.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/flag_map.png',
                  width: 30,
                  height: 30,
                ),
                const Text(
                  'ຊອກຫາຮ້ານໃຫ້ບໍລິການ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            // Container(
            //   decoration: BoxDecoration(
            //     color: const Color.fromARGB(255, 229, 228, 228),
            //     borderRadius: BorderRadius.circular(50),
            //   ),
            //   child: InkWell(
            //     borderRadius: BorderRadius.circular(10),
            //     onTap: () {
            //       Get.toNamed('/Map');
            //     },
            //     child: Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Row(
            //         children: [
            //           Image.asset(
            //             'assets/images/location-pin.png',
            //             width: 16,
            //             height: 16,
            //             color: Colors.black54,
            //           ),
            //           const SizedBox(
            //             width: 5.0,
            //           ),
            //           const Text(
            //             'ແຜນທີ່',
            //             style: TextStyle(
            //               color: Colors.black,
            //               fontSize: 14,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // )
            MouseRegion(
              onHover: (event) {
                // Set border color when hovered
                setState(() {
                  isHovered = true;
                });
              },
              onExit: (event) {
                // Reset border color when not hovered
                setState(() {
                  isHovered = false;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 229, 228, 228),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: isHovered ? Colors.blue : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    Get.toNamed('/Map');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/location-pin.png',
                          width: 16,
                          height: 16,
                          color: Colors.black54,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        const Text(
                          'ແຜນທີ່',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
