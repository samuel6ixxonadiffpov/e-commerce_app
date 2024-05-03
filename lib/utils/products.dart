import 'package:agricapp/utils/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cart {
  List<Product> _items = [];

  // Add product to cart
  void addToCart(Product product) {
    _items.add(product);
  }

  // Remove product from cart
  void removeFromCart(Product product) {
    _items.remove(product);
  }

  // Calculate total price of items in cart
  double getTotalPrice() {
    double totalPrice = 0.0;
    for (var item in _items) {
      totalPrice += item.price;
    }
    return totalPrice;
  }

  // Get all items in cart
  List<Product> get items {
    return [..._items];
  }
}

Future<List<Product>> fetchProductsFromFirestore(
    {String? category, double? maxPrice}) async {
  List<Product> products = [];
  try {
    Query<Map<String, dynamic>> query =
        FirebaseFirestore.instance.collection('products');

    if (category != null) {
      query = query.where('category', isEqualTo: category);
    }

    if (maxPrice != null) {
      query = query.where('price', isLessThanOrEqualTo: maxPrice);
    }

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await query.get();

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      Map<String, dynamic> data = (doc.data() as Map<String, dynamic>);

      products.add(Product(
        name: data['name'],
        category: data['category'] ?? '',
        desc: data['desc'] ?? '',
        image: data['image'] ?? '',
        price: data['price'].toDouble(),
        rating: data['rating'].toDouble(),
        productId: data['productId'],
        unit: data['unit'],
        available: data['available'],
      ));
    }
  } catch (e) {
    print("Error fetching products: $e");
  }

  return products;
}
