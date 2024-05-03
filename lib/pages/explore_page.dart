import 'package:agricapp/utils/my_card.dart';
import 'package:agricapp/utils/product.dart';
import 'package:agricapp/utils/products.dart';
import 'package:agricapp/widgets/product_cardd.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  late Future<List<Product>> _futureProducts;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _futureProducts = fetchProductsFromFirestore();
  }

  Future<void> _refreshProducts() async {
    setState(() {
      _futureProducts = fetchProductsFromFirestore();
    });
  }

  List<Product> _searchProducts(List<Product> products, String query) {
    if (query.isEmpty) {
      return products;
    }
    return products
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshProducts,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Search field
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: 'Search products...',
                      isDense: true,
                      contentPadding: const EdgeInsets.all(12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(99),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      prefixIcon: Icon(IconlyLight.search),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: IconButton(
                    onPressed: () {
                      _searchController.clear();
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.eco,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const MyCard(),
            // Featured Products
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Featured Products',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'See All',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // FutureBuilder
            FutureBuilder<List<Product>>(
              future: _futureProducts,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  // Filter products based on search query
                  final List<Product> filteredProducts = _searchProducts(
                      snapshot.data ?? [], _searchController.text);
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.9,
                    ),
                    itemBuilder: (context, index) {
                      return ProductCard(product: filteredProducts[index]);
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
