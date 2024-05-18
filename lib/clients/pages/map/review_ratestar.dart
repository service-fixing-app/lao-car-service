import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:service_fixing/constants.dart';

class ReviewRatingStar extends StatefulWidget {
  const ReviewRatingStar({super.key});

  @override
  State<ReviewRatingStar> createState() => _ReviewRatingStarState();
}

class _ReviewRatingStarState extends State<ReviewRatingStar> {
  TextEditingController comment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ການໃຫ້ດາວ ແລະ ໃຫ້ຄວາມຄິດເຫັນ',
          style: TextStyle(
            fontFamily: 'phetsarath_ot',
          ),
        ),
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. '),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RatingBar.builder(
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
                    itemSize: 50.0,
                    onRatingUpdate: (rating) {
                      // print(rating);
                    },
                  ),
                ],
              ),
              // const SizedBox(height: 20),
              // SizedBox(
              //   height: 45.0,
              //   width: 100.0,
              //   child: ElevatedButton(
              //     onPressed: () {
              //       // any logic
              //     },
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.blue,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(50.0),
              //       ),
              //       padding: const EdgeInsets.all(0),
              //     ),
              //     child: const Center(child: Text('ໃຫ້ດາວ')),
              //   ),
              // ),
              const SizedBox(height: 20),
              const Divider(height: 2),
              const SizedBox(height: 20),
              const Text('Comment'),
              const SizedBox(height: 20),
              TextField(
                controller: comment,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: 'ປ້ອນຂໍ້ຄວາມປະກອບຄຳຄິດເຫັນຂອງທ່ານ',
                  labelStyle: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'phetsarath_ot',
                    fontWeight: FontWeight.w500,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(width: 2.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 18.0,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 45.0,
                width: 300.0,
                child: OutlinedButton(
                  onPressed: () {
                    //
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    padding: const EdgeInsets.all(0),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_a_photo),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'ເພີ່ມຮູບພາບ',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 45.0,
                child: ElevatedButton(
                  onPressed: () {
                    // any logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    padding: const EdgeInsets.all(0),
                  ),
                  child: const Center(child: Text('Post')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
