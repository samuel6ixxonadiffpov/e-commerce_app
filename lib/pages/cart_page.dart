import 'package:agricapp/controllers/cart.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartItems =
        CartController.getInstance().cart; // Maintain a list of cart items
    double totalPrice = 5000; // Initialize total price

    // Calculate total price
    cartItems.forEach((product) {
      totalPrice += product.price;
    });

    return Scaffold(
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final product = cartItems[index];
          return ListTile(
            title: Text(product.productName),
            subtitle: Text('₦${product.price}'),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child:
              Text('Total: ₦$totalPrice , No of items : ${cartItems.length}'),
        ),
      ),
    );
  }
}
