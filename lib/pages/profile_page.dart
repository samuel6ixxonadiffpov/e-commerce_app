import 'package:agricapp/pages/onboardinpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
//import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatelessWidget {
  final String userName, email, profilePicUrl;

  const ProfilePage(
      {super.key,
      required this.userName,
      required this.email,
      required this.profilePicUrl});

  @override
  Widget build(BuildContext context) {
    void signOut() async {
      await FirebaseAuth.instance.signOut();
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OnboardingPage(),
        ),
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 15),
            child: CircleAvatar(
              radius: 62,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: CircleAvatar(
                radius: 60,
                foregroundImage: NetworkImage(profilePicUrl),
              ),
            ),
          ),
          Center(
            child: Text(
              userName,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Center(
            child: Text(
              email,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const SizedBox(height: 25),
          ListTile(
            title: const Text("Adress"),
            subtitle: const Text('29, Cole street, Fadeyi Lagos'),
            leading: const Icon(IconlyLight.location),
            trailing: const Icon(IconlyLight.arrowRight2),
            onTap: () {
              /*   Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrdersPage(),
                  ));*/
            },
          ),
          ListTile(
            title: const Text("Orders"),
            leading: const Icon(IconlyLight.bag2),
            trailing: const Icon(IconlyLight.arrowRight2),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Viewed"),
            leading: const Icon(Icons.remove_red_eye_outlined),
            trailing: const Icon(IconlyLight.arrowRight2),
            onTap: () {},
          ),
          ListTile(
            title: const Text("About us"),
            leading: const Icon(IconlyLight.infoSquare),
            trailing: const Icon(IconlyLight.arrowRight2),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Wish list"),
            leading: const Icon(IconlyLight.heart),
            trailing: const Icon(IconlyLight.arrowRight2),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Logout"),
            leading: const Icon(IconlyLight.logout),
            onTap: () {
              signOut();
            },
          ),
        ],
      ),
    );
  }
}
