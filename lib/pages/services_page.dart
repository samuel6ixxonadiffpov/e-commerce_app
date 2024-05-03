import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:agricapp/utils/service.dart';
import 'package:agricapp/utils/services.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({Key? key}) : super(key: key);

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  late Future<List<Services>> _futureServices;

  @override
  void initState() {
    super.initState();
    _futureServices = fetchServicesFromFirestore();
  }

  Future<void> _refreshServices() async {
    setState(() {
      _futureServices = fetchServicesFromFirestore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshServices,
        child: FutureBuilder<List<Services>>(
          future: _futureServices,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text('No services found.'),
              );
            } else {
              return GridView.builder(
                padding: EdgeInsets.all(16),
                itemCount: snapshot.data!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0 + 4,
                    mainAxisSpacing: 8.0 + 4,
                    childAspectRatio: 0.85),
                itemBuilder: (context, index) {
                  return _buildServiceItem(snapshot.data![index]);
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildServiceItem(Services service) {
    return GestureDetector(
      onTap: () {
        // Handle service item tap
      },
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(service.image),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white.withOpacity(0.2),
              ),
              child: Text(
                service.name,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
