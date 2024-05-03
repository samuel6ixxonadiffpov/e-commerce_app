import 'package:flutter/material.dart';

class MyTile extends StatelessWidget {
  IconData icon, trailing;
  String? title, subtitle;
  Function onTapped;

  MyTile({
    super.key,
    required this.icon,
    required this.onTapped,
    required this.subtitle,
    required this.title,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile();
  }
}
