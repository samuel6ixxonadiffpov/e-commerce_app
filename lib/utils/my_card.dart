import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: SizedBox(
        height: 170,
        child: Card(
          color: Colors.green.shade50,
          elevation: 0.1,
          shadowColor: Colors.green.shade50,
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Consultation",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.green.shade700,
                            ),
                      ),
                      const Text('Get support from our customer service'),
                      FilledButton(onPressed: () {}, child: Text('Call now'))
                    ],
                  ),
                ),
                Image.asset(
                  'assets/contact_us.png',
                  width: 140,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
