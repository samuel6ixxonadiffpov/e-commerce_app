// ignore: unused_import
import 'dart:developer';

import 'package:agricapp/pages/cart_page.dart';
import 'package:agricapp/pages/explore_page.dart';
import 'package:agricapp/pages/profile_page.dart';
import 'package:agricapp/pages/services_page.dart';
import 'package:agricapp/utils/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:badges/badges.dart' as badge;

class HomePage extends StatefulWidget {
  final String userName, email, profilePicUrl;
  const HomePage(
      {super.key,
      required this.userName,
      required this.email,
      required this.profilePicUrl});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    //helps display current page
    final List<Map<String, dynamic>> pages = [
      {
        'page': const ExplorePage(),
      },
      {
        'page': const ServicesPage(),
        'title': 'Services',
      },
      {
        'page': const CartPage(),
        'title': 'Cart',
      },
      {
        'page': ProfilePage(
            profilePicUrl: widget.profilePicUrl,
            email: widget.email,
            userName: widget.userName),
        'title': 'Profile',
      }
    ];
    return Scaffold(
      //drawer
      drawer: MyDrawer(
          profilePicUrl: widget.profilePicUrl,
          email: widget.email,
          userName: widget.userName),
      //Appbar
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi, ${widget.userName}",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text('Enjoy our services!',
                style: Theme.of(context).textTheme.bodySmall)
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: IconButton.filledTonal(
              onPressed: () {},
              icon: badge.Badge(
                badgeContent: const Text(
                  '2',
                  style: TextStyle(fontSize: 12, color: Colors.white),
                ),
                badgeStyle: const badge.BadgeStyle(badgeColor: Colors.green),
                position: badge.BadgePosition.topEnd(top: -16, end: -12),
                child: Icon(IconlyBroken.notification),
              ),
            ),
          ),
        ],
      ),
      body: pages[_currentIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(IconlyLight.home),
              activeIcon: Icon(IconlyBold.home),
              label: 'Home'),
          BottomNavigationBarItem(
              activeIcon: Icon(IconlyBold.call),
              icon: Icon(IconlyLight.call),
              label: 'Services'),
          BottomNavigationBarItem(
              activeIcon: Icon(IconlyBold.buy),
              icon: Icon(IconlyLight.buy),
              label: 'Cart'),
          BottomNavigationBarItem(
              activeIcon: Icon(IconlyBold.profile),
              icon: Icon(IconlyLight.profile),
              label: 'Profile'),
        ],
      ),
    );
  }
}
