import 'package:agricapp/controllers/cart.dart';
import 'package:agricapp/utils/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:agricapp/data/cart.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.product});
  final Product product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool _showMore = false;
  late TapGestureRecognizer readMore;
  late List<Product> relatedProducts;
  late Future<List<Product>> _futureRelatedProducts;

  @override
  void initState() {
    super.initState();
    // Initialize future related products
    _futureRelatedProducts = fetchRelatedProducts(widget.product.category);
    // Fetch related products when the widget is initialized
    _futureRelatedProducts.then((products) {
      setState(() {
        relatedProducts = products;
      });
    });
    readMore = TapGestureRecognizer()
      ..onTap = () {
        setState(() {
          _showMore = !_showMore;
        });
      };
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    readMore.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Details',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(IconlyBroken.bookmark))
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            height: 250,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(widget.product.image), fit: BoxFit.cover),
            ),
          ),
          Text(
            widget.product.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 2 + 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.product.available
                    ? 'Available in stock'
                    : 'Out of stock',
                style: TextStyle(
                  fontSize: 14,
                  color: widget.product.available ? Colors.green : Colors.red,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '₦${widget.product.price}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    TextSpan(
                      text: '/${widget.product.unit}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Icon(
                Icons.star,
                size: 16,
                color: Colors.yellow.shade600,
              ),
              Text("${widget.product.rating} (192)"),
              Spacer(),
              SizedBox(
                height: 30,
                width: 30,
                child: IconButton.filled(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  iconSize: 18,
                  icon: const Icon(
                    Icons.remove,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: Text(
                  "5 ${widget.product.unit}",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 30,
                width: 30,
                child: IconButton.filled(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  iconSize: 18,
                  icon: const Icon(
                    Icons.add,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Description',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 5,
          ),
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                TextSpan(
                    text: _showMore
                        ? widget.product.desc
                        : '${widget.product.desc.substring(
                            0,
                            widget.product.desc.length - 90,
                          )}...'),
                TextSpan(
                    recognizer: readMore,
                    text: _showMore ? ' Read less' : ' Read more',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Related products',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          // Use FutureBuilder to handle asynchronous fetching
          FutureBuilder<List<Product>>(
            future: _futureRelatedProducts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Show loading indicator while fetching related products
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // Show error message if fetching related products fails
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                // Build related products UI if fetching is successful
                // Build related products UI if fetching is successful
                return SizedBox(
                  height: 90,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      // Exclude the main product from the related products list
                      final relatedProduct = snapshot.data![index];
                      if (relatedProduct.name == widget.product.name) {
                        // Skip displaying the main product
                        return SizedBox.shrink();
                      } else {
                        // Build your related product item here
                        return GestureDetector(
                          onTap: () {
                            // Navigate to the details page of the related product
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductDetailsPage(product: relatedProduct),
                              ),
                            );
                          },
                          child: Container(
                            height: 80,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  relatedProduct.image,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 10,
                    ),
                    itemCount: snapshot.data!.length,
                  ),
                );
              }
            },
          ),
          const SizedBox(
            height: 28,
          ),
          FilledButton.icon(
            onPressed: () {
              CartController.getInstance().push(
                CartModel(
                  price: widget.product.price,
                  quantity: 1,
                  discount: 0,
                  productName: widget.product.name,
                  productId: widget.product.productId,
                  productImage: widget.product.image,
                ),
              );
            },
            label: const Text('Add to cart'),
            icon: const Icon(IconlyLight.bag2),
          )
        ],
      ),
    );
  }

  // Method to fetch related products from Firestore based on the category of the current product
  Future<List<Product>> fetchRelatedProducts(String category) async {
    List<Product> products = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('products')
              .where('category', isEqualTo: category) // Filter by category
              .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc
          in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();
        products.add(Product(
          //  productId: data['productId'] ?? '',
          name: data['name'] ?? '',
          image: data['image'] ?? '',
          price: data['price'].toDouble() ?? 0.0,
          rating: data['rating'].toDouble() ?? 0.0,
          unit: data['unit'] ?? '',
          available: data['available'] ?? false,
          category: data['category'] ?? '',
          desc: data['desc'] ?? '',
          productId: data['productId'],

          // Add other details of the related product
        ));
      }
    } catch (e) {
      print("Error fetching related products: $e");
      throw Exception("Failed to fetch related products");
    }
    return products;
  }
}
