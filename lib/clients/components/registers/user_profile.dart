import 'package:flutter/material.dart';
import '../../../constants.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Stack(
        children: [
          ProfileImage(),
          Positioned(
            bottom: 0,
            right: 155,
            child: EditImageProfile(),
          ),
        ],
      ),
    );
  }
}

class EditImageProfile extends StatelessWidget {
  const EditImageProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          border: Border.all(
            color: Colors.white,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Icon(
          Icons.camera_alt_rounded,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle profile picture upload
      },
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color.fromARGB(255, 225, 224, 224),
              width: 2.0,
            ),
          ),
          child: const CircleAvatar(
            radius: 55,
            backgroundColor: bgColor,
            backgroundImage: AssetImage(
              'assets/images/user_profile.gif',
            ),
          ),
        ),
      ),
    );
  }
}
