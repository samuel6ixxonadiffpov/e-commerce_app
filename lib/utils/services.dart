import 'package:agricapp/utils/service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Services>> fetchServicesFromFirestore() async {
  List<Services> services = [];
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('services').get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc
        in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data();
      services.add(Services(
        name: data['name'],
        image: data['image'],
      ));
    }
  } catch (e) {
    print("Error fetching services: $e");
    throw Exception('Failed to fetch services');
  }
  return services;
}
