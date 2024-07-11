
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:service_fixing/clients/controllers/reviews/getReviews_controller.dart';

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