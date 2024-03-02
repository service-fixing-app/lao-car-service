import 'package:flutter/material.dart';
import 'package:service_fixing/clients/components/body_section.dart';
import 'package:service_fixing/clients/components/find_map.dart';
import '../components/cover_image.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  CoverImage(),
                  Positioned(
                    top: CoverImage.coverHeight / 1.2,
                    left: 0,
                    right: 0,
                    child: FindMap(),
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              BodySection(),
            ],
          ),
        ),
      ),
    );
  }
}
