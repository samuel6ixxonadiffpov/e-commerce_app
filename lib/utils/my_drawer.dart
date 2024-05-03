import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final String userName, email, profilePicUrl;

  const MyDrawer({
    super.key,
    required this.email,
    required this.profilePicUrl,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: ListView(
        children: [
          Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text('${userName}'),
                accountEmail: Text('${email}'),
                currentAccountPicture: Image.network(profilePicUrl),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
